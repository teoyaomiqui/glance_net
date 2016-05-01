notice('MODULAR: glance_net:ha_endpoint.pp')
$network_metadata     = hiera_hash('network_metadata')
$pub_ip               = hiera('public_vip')
$pub_protocol         = 'http'
$adm_ip               = $network_metadata['vips']['glance']['ipaddr']
$int_ip               = $network_metadata['vips']['glance']['ipaddr']
$region               = 'RegionOne'
$glance_endpoint_port  = '9292'

keystone_endpoint {"${region}/glance":
  ensure       => present,
  public_url   => "${pub_protocol}://${pub_ip}:${glance_endpoint_port}",
  admin_url    => "http://${adm_ip}:${glance_endpoint_port}",
  internal_url => "http://${int_ip}:${glance_endpoint_port}",
}

$public_ssl_hash   = hiera('public_ssl')
$ssl_hash          = hiera_hash('use_ssl', {})

$public_ssl        = get_ssl_property($ssl_hash, $public_ssl_hash, 'glance', 'public', 'usage', false)
$public_ssl_path   = get_ssl_property($ssl_hash, $public_ssl_hash, 'glance', 'public', 'path', [''])

$internal_ssl      = get_ssl_property($ssl_hash, {}, 'glance', 'internal', 'usage', false)
$internal_ssl_path = get_ssl_property($ssl_hash, {}, 'glance', 'internal', 'path', [''])

$glances_address_map = get_node_to_ipaddr_map_by_network_role(get_nodes_hash_by_roles($network_metadata, ['primary-controller', 'controller']), 'glance/vip')

  $server_names        = hiera_array('glance_names', keys($glances_address_map))
  $ipaddresses         = hiera_array('glance_ipaddresses', values($glances_address_map))
  $internal_virtual_ip = hiera('management_vip')

class { '::openstack::ha::glance':
  internal_virtual_ip => $int_ip,
  ipaddresses         => $ipaddresses,
  public_virtual_ip   => $pub_ip,
  server_names        => $server_names,
  public_ssl          => $public_ssl,
  public_ssl_path     => $public_ssl_path,
  internal_ssl        => $internal_ssl,
  internal_ssl_path   => $internal_ssl_path,
}

