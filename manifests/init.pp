# Class: lsyncd
#
# lsyncd.
#
# Sample Usage :
#  class { 'lsyncd': config_source => 'puppet:///modules/example/lsyncd.conf' }
#
class lsyncd (
  $config_source  = undef,
  $config_content = undef,
  $logdir_owner   = 'root',
  $logdir_group   = 'root',
  $logdir_mode    = '0755'
) {

  package { 'lsyncd': ensure => installed }

  service { 'lsyncd':
    enable    => true,
    ensure    => running,
    hasstatus => true,
    require   => Package['lsyncd'],
  }

  file { '/etc/lsyncd.conf':
    source  => $config_source,
    content => $config_content,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['lsyncd'],
    require => Package['lsyncd'],
  }

  # As of 2.1.4-3.el6 the rpm package doesn't include this directory
  file { '/var/log/lsyncd':
    owner  => $logdir_owner,
    group  => $logdir_group,
    mode   => $logdir_mode,
    ensure => directory,
  }

}

