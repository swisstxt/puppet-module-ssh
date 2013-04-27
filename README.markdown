ssh
====


Overview
--------

The ssh module handles the openssh server package, and its configuration on a server.


Module Description
-------------------

The ssh module allows Puppet to handle the openssh server package, and its configuration on a server.

Setup
-----

**What ssh affects:**

* the sshd_config file located in /etc/ssh
* whether the openssh-server package is installed or not
* whether the openssh-server package is auto updated or not
	
### Beginning with ssh

To setup ssh on a server

    class { 'ssh::server':
      ensure     => 'running',
      enable     => true,
      autoupdate => false,
      config     => 'sshd_config'
    }

Usage
------

The `ssh::server` class definition has several parameters to assist installation of ssh.

**Parameters within `ssh`**

####`ensure`

This parameter specifies whether the ssh daemon should be running or not.
Valid arguments are running or stopped. Default is running.

####`enable`

This parameter specifies whether the ssh daemon should start on system boot or not.
Valid arguments are true or false. Default is true.

####`autoupdate`

This parameter specifies whether the openssh server package should be updated when a new update is available or not.

####`config`

This parameter specifies the ssh server configuration file.
It must be present in the files directory of the caller module.

If not specified, it defaults to a basic configuration of sshd provided with this module. You may use it as a base.

Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* CentOS 5.9
* CentOS 6.4
* Debian 6.0 
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Bug Reports
-----------

Release Notes
--------------

**0.0.1**

First initial release.
