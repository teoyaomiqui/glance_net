notice('MODULAR: glance_net_nova_config')
$network_metadata   = hiera_hash('network_metadata')
$glance_endpoint_ip    = $network_metadata['vips']['glance']['ipaddr']
$glance_endpoint_port  = '9292'
$services = ['nova-api', 'cinder-api', 'glance-api']

service{ $services:
    ensure => running,
}

nova_config {
    'glance/api_servers':          value  => "${glance_endpoint_ip}:${glance_endpoint_port}",
}
glance_api_config {
    'DEFAULT/registry_host':       value  => "${glance_endpoint_ip}",
}
cinder_config {
    'DEFAULT/glance_api_servers':  value  => "${glance_endpoint_ip}:${glance_endpoint_port}",
}

Cinder_config <||> ~> Service['cinder-api']
Nova_config <||> ~> Service['nova-api']
Glance_api_config<||> ~> Service['glance-api']

