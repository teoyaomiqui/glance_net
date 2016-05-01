notice('MODULAR: glance_net_cinder_config')
$network_metadata   = hiera_hash('network_metadata')
$glance_endpoint    = $network_metadata['vips']['glance']['ipaddr']

service{ 'cinder-api':
    ensure => running,
}
cinder_config {
    'glance/api_servers':  value  => $glance_endpoint,
}
Cinder_config <||> ~> Service['cinder-api']

