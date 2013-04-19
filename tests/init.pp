class { 'ssh::server':
  ensure     => 'running',
  enable     => true,
  autoupdate => false,
  config     => ''
}