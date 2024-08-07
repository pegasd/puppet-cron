# Configure and manage cron jobs with focus on tidiness

[![Build Status](https://github.com/pegasd/puppet-cron/actions/workflows/ci.yml/badge.svg?branch=main)](https://travis-ci.org/pegasd/puppet-cron)
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

**WARNING**: All existing unmanaged cron jobs will be purged!

## Usage

### Also manage /etc/cron.d directory
```puppet
class { 'cron':
  purge_crond => true,
}
```

Same result through Hiera:

```yaml
cron::purge_crond: true
```

### Wipe it all out
```puppet
class { 'cron':
  ensure => absent,
}
```

Same result through Hiera:

```yaml
cron::ensure: absent
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


### cron::whitelist example

```puppet
cron::whitelist { 'pkg_backup': }
```
This will make `/etc/cron.d/pkg_backup` immune, and keep the file's contents untouched.

## Reference

### Type Aliases

* `Cron::Command` - Used for `cron::job::command` parameter. Does not allow newline characters (which breaks crontab).
* `Cron::User` - Match username to fail early if invalid username is provided.
* `Cron::Minute` - Stricter `cron::job::minute`.
* `Cron::Hour` - Stricter `cron::job::hour`.
* `Cron::Monthday` - Stricter `cron::job::monthday`.
* `Cron::Month` - Stricter `cron::job::month`.
* `Cron::Weekday` - Stricter `cron::job::weekday`.

### Full reference

Check out [REFERENCE](REFERENCE.md) for up-to-date details.

## Limitations

* Made for and tested only on the following Ubuntu distributions:
    * 18.04
    * 20.04
    * 22.04
* Custom `Cron::*` time types are a lot stricter than builtin `cron` ones. Careful - this may break existing cron jobs
  you are converting.
* All cron jobs managed by built-in `cron` type are fair play. They won't be purged as long as they're in the catalog.
  But using this module's `cron::job` type does have its advantages.

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to [submit an issue](https://github.com/pegasd/puppet-cron/issues) /
[fire up a PR](https://github.com/pegasd/puppet-cron/pulls) / whatever.
