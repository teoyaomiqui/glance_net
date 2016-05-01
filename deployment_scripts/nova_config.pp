notice('MODULAR: glance_net_nova_config')
$network_metadata   = hiera_hash('network_metadata')
$glance_endpoint    = $network_metadata['vips']['glance']['ipaddr']

service{ 'nova-api':
    ensure => running,
}
nova_config {
    'glance/api_servers':  value  => $glance_endpoint ,
}
Nova_config <||> ~> Service['nova-api']

