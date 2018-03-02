# cron

[![master branch status](https://travis-ci.org/pegasd/puppet-cron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-cron)

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
class { '::cron':
  purge_crond => true,
}
```

### Wipe it all out
```puppet
class { '::cron': ensure => absent }
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
NB: My custom types are a lot stricter than default cron types. Careful - this may break existing cron jobs you are
converting.

### cron::whitelist example
```puppet
cron::whitelist { 'pkg_backup': }
```
This will make `/etc/cron.d/pkg_backup` immune, and keep the file's contents untouched.

## Reference

### Classes

#### Public classes

* [`cron`](#cron): Main entry point, must include to start managing cron jobs.

#### Private classes

* `cron::install`
* `cron::config`
* `cron::service`
* `cron::remove`

### Defined Resource Types

* [`cron::job`](#cronjob)
* [`cron::whitelist`](#cronwhitelist)

### Custom Types

* `Cron::Minute`
* `Cron::Hour`
* `Cron::Monthday`
* `Cron::Month`
* `Cron::Weekday`

### Parameters

#### cron

##### `ensure`

Whether cron should exist on host or not

##### `purge_crond`

Also purge files in /etc/cron.d directory (whitelist required jobs using [`cron::whitelist`](#cronwhitelist))

#### cron::job

##### `command`

Command path to be executed

##### `user`

The user who owns the cron job

##### `minute`

Cron minute

##### `hour`

Cron hour

##### `monthday`

Cron monthday

##### `month`

Cron month

##### `weekday`

Cron weekday

#### cron::whitelist

`cron::whitelist` does not have any arguments. Just use a unique name and we'll find it in `/etc/cron.d`

## Limitations

* Made for and tested only on Ubuntu
* `Cron::*` custom types are strict!
* all cron jobs that are managed manually through Puppet are fair play. Don't expect them to
go away once you start using this module. Hopefully, you can easily convert them to `cron::job` though.
* the warnings from [Beginning with cron](#beginningwithcron) apply

## Development

I'll be happy to know you're using this for one reason or another. And if you want to contribute - even better!
Feel free to submit a pull request.
