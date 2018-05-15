# Configure and manage cron jobs with focus on tidiness

[![Build Status](https://travis-ci.org/pegasd/puppet-cron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-cron)
[![Puppet Forge](https://img.shields.io/puppetforge/v/pegas/cron.svg)](https://forge.puppetlabs.com/pegas/cron)
[![Puppet Forge - Downloads](https://img.shields.io/puppetforge/dt/pegas/cron.svg)](https://forge.puppetlabs.com/pegas/cron)
[![Puppet Forge - Score](https://img.shields.io/puppetforge/f/pegas/cron.svg)](https://forge.puppetlabs.com/pegas/cron)

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cron](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module is an interface for cron jobs with the main idea to be tidy. That means that any jobs that are not managed
should not exist. Once you switch all cron jobs to this module, simply removing the definition is sufficient without
worrying about setting `ensure => disable` and waiting for changes to propagate.

## Setup

### Beginning with cron

To start out with cron:
```puppet
include cron
```
This will start purging all unmanaged cron resources and also make sure the 'cron' package is installed and the service is running.

**WARNING #1**: All existing unmanaged cron jobs will be purged!

## Usage

### Also manage /etc/cron.d directory
```puppet
class { 'cron':
  purge_crond => true,
}
```

### Wipe it all out
```puppet
class { 'cron':
  ensure => absent,
}
```

### cron::job example

```puppet
cron::job { 'backup':
  user     => 'backup', # default: 'root'
  minute   => '3-59/5',
  hour     => '9-17',
  monthday => '*/2',
  month    => [ 4, 8, 12 ],
  weekday  => '0-4',
}
```

> Custom `Cron::*` time types are a lot stricter than builtin `cron` ones. Careful - this may break existing cron jobs
  you are converting.

### cron::whitelist example

```puppet
cron::whitelist { 'pkg_backup': }
```
This will make `/etc/cron.d/pkg_backup` immune, and keep the file's contents untouched.

## Reference

### Classes

#### Public Classes

* [`cron`](#cron): Main entry point into all cron-related resources on the host. It purges by default. You've been warned!

#### Private Classes

* `cron::config`: Various cron configuration files
* `cron::install`: This class handles cron packages.
* `cron::purge`: This is where all the purging magic happens. Purge unmanaged cron jobs and also, optionally, purge `/etc/cron.d` directory.
* `cron::remove`: This class handles removal of all cron-related resources.
* `cron::service`: This class handles cron service.

### Defined types

* [`cron::job`](#cronjob): Cron job defined type with a bit of magic dust sprinkled all over.
* [`cron::whitelist`](#cronwhitelist): Use this to whitelist any system cron jobs you don't want this module to touch. This will make sure `/etc/cron.d/${title}` won't get deleted 

### Functions

* [`cron::prep4cron`](#cronprep4cron): This functions prepares any cron::job custom timing value to be used as Puppet internal cron's resource argument

### Custom Types

* `Cron::Minute`
* `Cron::Hour`
* `Cron::Monthday`
* `Cron::Month`
* `Cron::Weekday`

### More information

Parameters, examples, and more: [REFERENCE](REFERENCE.md).

## Limitations

* Made for and tested only on the following Ubuntu distributions:
  * 14.04
  * 16.04
  * 18.04
* `Cron::*` custom types are strict!
* All cron jobs managed by built-in `cron` type are fair play. They won't be purged as long
  as they're in the catalog. But using this module's `cron::job` type does have its advantages.

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to [submit an issue](https://github.com/pegasd/puppet-cron/issues) /
[fire up a PR](https://github.com/pegasd/puppet-cron/pulls) / whatever.

