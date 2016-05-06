notice('MODULAR: glance_net_nova_compute.pp')
$network_metadata      = hiera_hash('network_metadata')
$glance_endpoint_ip    = $network_metadata['vips']['glance']['ipaddr']
$glance_endpoint_port  = '9292'
$services              = ['nova-compute']

service { 
    $services:               ensure => running,
}

nova_config {
    'glance/api_servers':    value  => "${glance_endpoint_ip}:${glance_endpoint_port}",
}


Nova_config <||> ~> Service[$services]

