class ssh::server (
  $ensure     = 'running',
  $enable     = true,
  $autoupdate = false,
  $config     = undef) {
  # validate parameters
  if !($ensure in ['running', 'stopped']) {
    fail('ensure parameter must be running or stopped')
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail('autoupdate parameter must be true or false')
  }

  if $config == undef {
    $config_tpl = template("${module_name}/default-sshd_config.erb")
  } else {
    $config_tpl = template("${caller_module_name}/${config}")
  }

  case $::osfamily {
    RedHat  : {
      $supported = true
      $pkg_name = ['openssh-server']
      $svc_name = 'sshd'
      $config_file = '/etc/ssh/sshd_config'

    }
    Debian  : {
      $supported = true
      $pkg_name = ['openssh-server']
      $svc_name = 'ssh'
      $config_file = '/etc/ssh/sshd_config'
    }
    default : {
      fail("${module_name} module is not supported on ${::osfamily} based systems")
    }
  }

  package { $pkg_name:
    ensure => $package_ensure
  }

  file { $config_file:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0600',
    content => $config_tpl,
    notify  => Service[$svc_name],
    require => Package[$pkg_name],
  }

  service { $svc_name:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package[$pkg_name], File[$config_file]],
  }
}

