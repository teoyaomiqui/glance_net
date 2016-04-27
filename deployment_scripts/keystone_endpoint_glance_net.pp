$public_protocol     = get_ssl_property($ssl_hash, $public_ssl_hash, 'glance', 'public', 'protocol', 'http')
$public_address      = get_ssl_property($ssl_hash, $public_ssl_hash, 'glance', 'public', 'hostname', [$public_vip])
$internal_protocol   = get_ssl_property($ssl_hash, {}, 'glance', 'internal', 'protocol', 'http')
$internal_address    = get_ssl_property($ssl_hash, {}, 'glance', 'internal', 'hostname', [$glance_network_vip])
$admin_protocol      = get_ssl_property($ssl_hash, {}, 'glance', 'admin', 'protocol', 'http')
$admin_address       = get_ssl_property($ssl_hash, {}, 'glance', 'admin', 'hostname', [$glance_network_vip])

$public_url = "${public_protocol}://${public_address}:9292"
$internal_url = "${internal_protocol}://${internal_address}:9292"
$admin_url  = "${admin_protocol}://${admin_address}:9292"

ensure_resource('keystone_endpoint', "${region}/${service_name_real}", {
    'ensure'       => 'present',
    'public_url'   => $public_url,
    'admin_url'    => $admin_url,
    'internal_url' => $internal_url,
})

