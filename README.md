# cron

[![master branch status](https://travis-ci.org/pegasd/puppet-cron.svg?branch=master)](https://travis-ci.org/pegasd/puppet-cron)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cron](#setup)
    * [What cron affects](#what-cron-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cron](#beginning-with-cron)
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
This will start managing `/etc/cron.d` directory, and also make sure we have the package installed and the service is
running.

**WARNING #1**: Unless you manage files with Puppet in this directory, they WILL be removed! This is the major idea behind the
tidiness of this module.

**WARNING #2**: regular cron resources must be cleaned out using `ensure => absent` prior to using this module. Otherwise you'll get 
duplicates.

## Usage

### Custom cron.d permissions
```puppet
class { '::cron':
  dir_mode => '0750', # default: '0755'
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
This will make `/etc/cron.d/pkg_backup` immune, but keep the content of the file unmanaged.

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

##### `dir_mode`

/etc/cron.d directory permissions

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

##### `mode`

Permissions for cron job file located in /etc/cron.d

#### cron::whitelist

`cron::whitelist` does not have any arguments. Just use a unique name and we'll find it in `/etc/cron.d`

## Limitations

* `Cron::*` custom types are strict!
* all files in `/etc/cron.d` directory that are managed manually through Puppet are fair play. Don't expect them to
go away once you start using this module. Hopefully, you won't need to manage them anymore, though.
* the warnings from [Beginning with cron](#beginningwithcron) apply

## Development

I'll be happy to know you're using this for one reason or another. And if you want to contribute - even better!
Feel free to submit a pull request.
