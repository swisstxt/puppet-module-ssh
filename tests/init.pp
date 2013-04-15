class { 'ssh::server':
  ensure => "running",
  enable => true,
}