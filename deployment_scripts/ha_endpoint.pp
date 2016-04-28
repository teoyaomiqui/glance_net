notice('MODULAR: glance_net:ha_endpoint.pp')
$pub_ip               = '10.109.16.3'
$pub_protocol         = 'http'
$adm_ip               = '10.109.16.3'
$int_ip               = '10.109.16.3'
$region               = 'RegionOne'
$glance_endpoint_port  = '9292'

keystone_endpoint {"${region}/glance":
  ensure       => present,
  public_url   => "${pub_protocol}://${pub_ip}:${glance_endpoint_port}",
  admin_url    => "http://${adm_ip}:${glance_endpoint_port}",
  internal_url => "http://${int_ip}:${glance_endpoint_port}",
}

