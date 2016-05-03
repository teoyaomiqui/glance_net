notice('MODULAR: glance_net_nova_config')
$network_metadata   = hiera_hash('network_metadata')
$glance_endpoint    = $network_metadata['vips']['glance']['ipaddr']
$services = ['nova-api', 'cinder-api']

service{ $services:
    ensure => running,
}
nova_config {
    'glance/api_servers':  value  => '$glance_endpointi:9292',
}
cinder_config {
    'DEFAULT/glance_api_servers':  value  => '$glance_endpoint:9292',
}

Cinder_config <||> ~> Service['cinder-api']
Nova_config <||> ~> Service['nova-api']


