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
  $logdir_mode    = '0755',
  $lsyncd_options = undef,
  # This parameter requires a modified rpm init script
  $lsyncd_user    = undef,
) inherits lsyncd::params {

  package { 'lsyncd': ensure => 'installed' }

  service { 'lsyncd':
    ensure    => 'running',
    enable    => true,
    hasstatus => true,
    require   => Package['lsyncd'],
  }

  file { $lsyncd::params::cfg_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => $config_source,
    content => $config_content,
    require => Package['lsyncd'],
    notify  => Service['lsyncd'],
  }

  file { '/etc/sysconfig/lsyncd':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/lsyncd-sysconfig.erb"),
    require => Package['lsyncd'],
    notify  => Service['lsyncd'],
  }

  # As of 2.1.4-3.el6 the rpm package doesn't include these directories
  # Later versions do, but we might need to change permissions
  if $::osfamily !~ /(Debian|Ubuntu)/ {
    file { [ '/var/log/lsyncd', '/var/run/lsyncd' ]:
      ensure  => 'directory',
      owner   => $logdir_owner,
      group   => $logdir_group,
      mode    => $logdir_mode,
      require => Package['lsyncd'],
      before  => Service['lsyncd'],
    }
  }
}
