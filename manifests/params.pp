class lsyncd::params {
  $cfg_path = $::osfamily ? {
    /(Debian|Ubuntu)/ => '/etc/lsyncd',
    default => '/etc',
  }
    
  $cfg_file = $::osfamily ? {
    /(Debian|Ubuntu)/ => "${cfg_path}/lsyncd.conf.lua",
    default => "${cfg_path}/lsyncd.conf",
  }
}
