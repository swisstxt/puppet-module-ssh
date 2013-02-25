# Class: ssh::server
#
# This module manages ssh server
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class ssh::server ($ensure = 'running', $enable = true, $autoupdate = false, $config = undef) {
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

  case $::osfamily {
    RedHat  : {
      $supported = true
      $pkg_name = ['openssh-server']
      $svc_name = 'sshd'
      $config = '/etc/ssh/sshd_config'

      if $config == undef {
        $config_tpl = template("${module_name}/default-redhat-sshd_config.erb")
      } else {
        $config_tpl = template("${caller_module_name}/${config}")
      }

    }
    default : {
      fail("${module_name} module is not supported on ${::osfamily} based systems")
    }
  }

  package { $pkg_name: ensure => $package_ensure }

  file { $config:
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => $config_tpl,
    require => Package[$pkg_name],
  }

  service { $svc_name:
    ensure     => $ensure,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => [Package[$pkg_name], File[$config]],
  }
}

