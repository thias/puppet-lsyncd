# puppet-lsyncd

## Overview

Install, enable and configure lsyncd, the live syncing daemon.

* `lsyncd` : Main class to install, enable and configure the service.

## Examples

Simple instance using the `lsyncd.conf` file from a module named `example` :

    class { 'lsyncd': config_source => 'puppet:///modules/example/lsyncd.conf' }

If you are going to be interfacing lsyncd with csync2 to perform an all-way
near-instantaneous file synchronization, you can use the provided template :

    $lsyncd_csync2_sources = {
      '/var/www' => 'www',
      '/srv/data' => 'data',
    }
    class { 'lsyncd':
      config_content => template('lsyncd/lsyncd-csync2.conf.erb'),
    }

This will have lsyncd trigger `csync2 -C www -x` for changes made
to `/var/www` and `csync2 -C data -x` for changes made to `/srv/data`. Compared
to using rsync, using csync2 has the advantage of providing safe file deleting
in any direction.

