notice('MODULAR: service_configs.pp')
$services = ['nova-api', 'nova-scheduler', 'cinder-api']
$glance_endpoint = hiera('glance_network_vip')

service{ $services:
    ensure = > running
}
nova_config {
    'glance/api_servers':  value  => $glance_endpoint 
