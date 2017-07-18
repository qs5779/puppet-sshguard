# == Class: sshguard::configure
#
# === Authors
#
# Johannes Graf <graf.johannes@gmail.com>
#
# === Copyright
#
# Copyright 2014 Johannes Graf
#
class sshguard::config inherits sshguard {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { '/etc/sshguard/whitelist':
    ensure  => file,
    content => template("${module_name}/whitelist.erb"),
  }

  case $::osfamily {
    /^RedHat$/: {
      $cfgfile = '/etc/sysconfig/sshguard'
    }
    default: {
      $cfgfile = '/etc/default/sshguard'
    }
  }

  file { $cfgfile:
    ensure  => file,
    content => template("${module_name}/default.erb"),
  }

}
