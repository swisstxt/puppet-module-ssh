# Class: ssh
#
# The ssh module allows Puppet to handle the openssh server package,
# and its configuration on a server.
#
# Parameters: ensure, enable, autoupdate, config
#
# Sample Usage:
#    class { 'ssh::server':
#      ensure     => 'running',
#      enable     => true,
#      autoupdate => false,
#      config     => 'sshd_config'
#    }
#
class ssh {

}
