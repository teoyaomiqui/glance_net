notice('MODULAR: glance_net_service_configs.pp')
$services           = ['nova-api', 'nova-scheduler', 'cinder-api']
$network_metadata   = hiera_hash('network_metadata')
$glance_endpoint    = $network_metadata['vips']['glance']['ipaddr']

service{ $services:
    ensure => running,
}
nova_config {
    'glance/api_servers':  value  => $glance_endpoint ,
}
cinder_config {
    'glance/api_servers':  value  => $glance_endpoint,
}
Nova_config <||> ~> Service[$services]
Cinder_config <||> ~> Service[$services]

