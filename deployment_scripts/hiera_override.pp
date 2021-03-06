notice('MODULAR: glance_net_hiera_override.pp')
    $hiera_dir            = '/etc/hiera/plugins'
    $plugin_name          = 'glance_net'
    $override_yaml        = "${plugin_name}.yaml"

file { "${hiera_dir}/${plugin_name}":
    ensure     => directory
}

file { "${hiera_dir}/${override_yaml}":
    ensure     => file,
    content    => template('glance_net/glance_net_override_yaml.erb'),
    require => File["${hiera_dir}/${plugin_name}"],
}

