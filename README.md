# Make your cron and incron jobs behave

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

This module is an interface for cron jobs with the main goal to be tidy. At
our company we required an interface for specifying cron jobs and removing them
without waiting for puppet to run with `ensure => disable`. So, this is done by
managing `/etc/cron.d` directory with `purge => true`.

## Setup

### What cron affects

At this point this module has a single defined `cron::job` resource type which works similar
to the regular `cron` resource, but instead of managing user's cron, it creates a file in
`/etc/cron.d`.

### Beginning with cron

Get up and running by using `cron::job` resource like this:
```puppet
cron::job { 'my-backup':
  command => '/usr/local/bin/my-backup'
}
```
This will create a `/etc/cron.d/job_my-backup` file with a job that will run every minute.
That may actually be quite an overkill for your backup script, so make sure you read on
for customizations (-

## Usage

Usually there is no need to `include cron`, unless you want to specify custom permissions
for `/etc/cron.d` directory. If so, start out by doing
```puppet
class { 'cron':
  dir_mode => '0750'
}
```

## Reference

`cron::job` resource has the following defaults:
```puppet
cron::job { $title:
  command, # no default, MUST be specified
  mode     = '0644',
  user     = 'root',
  minute   = '*',
  hour     = '*',
  monthday = '*',
  month    = '*',
  weekday  = '*',
}
```
It is supposed to be as close to the regular Puppet's `cron` resource
as possible.

## Limitations

Although the `cron::job` type checks for Integer boundaries, you're on your own
if you are using strings for specifying time intervals.

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to submit a pull request.
