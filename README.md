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

This module is an interface for cron jobs with the main idea to be tidy. That means that any jobs that are not managed should not
exist. Once you switch all cron jobs to this module, simply removing the definition is sufficient without worrying about setting
`ensure => disable` and waiting for changes to propagate.

## Setup

### Beginning with cron

To start out with cron:
```puppet
include cron
```
This will start managing `/etc/cron.d` directory.

**WARNING #1**: Unless you manage files with Puppet in this directory, they WILL be removed! This is the major idea behind the
tidiness of this module.

**WARNING #2**: regular cron resources must be cleaned out using `ensure => absent` prior to using this module. Otherwise you'll get 
duplicates.

## Usage

All interactions with cron jobs should be done using `cron::job` resource.

## Reference

### Classes

#### Public classes

* [`cron`](#cron)

#### Private classes

* [`cron::install`](#croninstall)
* [`cron::config`](#cronconfig)
* [`cron::service`](#cronservice)
* [`cron::remove`](#cronremove)

### Resources

* [`cron::job`](#cronjob)

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

## Limitations

* although the `cron::job` type checks for Integer boundaries, you're on your own if you are using strings for specifying time intervals.
Those will be put into the template as-is.
* all files in `/etc/cron.d` directory that are managed manually through Puppet are fair play. Don't expect them to
go away once you start using this module. Hopefully, you won't need to manage them anymore, though.
* regular cron resources must be cleaned out using `ensure => absent` prior to using this module. Otherwise you'll get duplicates.

## Development

I'll be happy to know you're using this for one reason or the other. And if you want to
contribute - even better. Feel free to submit a pull request.
