# puppet-lsyncd

## Overview

Install, enable and configure lsyncd, the live syncing daemon.

* `lsyncd` : Main class to install, enable and configure the service.

## Examples

Simple instance using the `lsyncd.conf` file from a module named `example` :

    class { 'lsyncd': config_source => 'puppet:///modules/example/lsyncd.conf' }

