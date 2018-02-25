# Reference

## Classes
* [`cron`](#cron): This is the main entry point into all cron-related resources on. the host. And because of its "tidiness", be very careful to manage evertyhing. that is needed through this class and related resources.
* [`cron::config`](#cronconfig): Various cron configuration files
* [`cron::install`](#croninstall): This class handles cron packages.
* [`cron::purge`](#cronpurge): This is where all the purging magic happens.. Purge unmanaged cron jobs and also, optionally, purge /etc/cron.d directory
* [`cron::remove`](#cronremove): This class handles removal of all cron-related resources.. Avoid modifying and using private classes directly.
* [`cron::service`](#cronservice): This class handles cron service.. Avoid modifying and using private classes directly.
## Defined types
* [`cron::job`](#cronjob): cron job resource
* [`cron::whitelist`](#cronwhitelist): Use this to whitelist any system cron jobs you don't want this module to touch.. This will make sure `/etc/cron.d/${title}` won't get deleted or modified.
## Functions
* [`cron::prep4cron`](#cronprep4cron): cron::prep4cron function. . This functions prepares any cron::job custom timing value to be. used as Puppet internal cron's resource argument
## Classes

### cron

* **See also**
manpages
crontab(1), crontab(5), cron(8)

#### Examples
##### Declaring the cron class
```puppet
include cron
```

##### Also purge unmanaged files in /etc/cron.d directory
```puppet
class { 'cron': purge_crond => true }
```

##### Removing all cron-related resources from the system
```puppet
class { 'cron': ensure => absent }
```

##### Deny crontab(1) usage to all users except root
```puppet
class { 'cron': allowed_users => [ 'root' ] }
```


#### Parameters

The following parameters are available in the `cron` class.

##### `ensure`

Data type: `Enum[present, absent]`

Whether to enable or disable cron on the system.

Default value: present

##### `purge_crond`

Data type: `Boolean`

Also purge unmanaged files in /etc/cron.d directory

Default value: `false`

##### `purge_noop`

Data type: `Boolean`

Run purging in `noop` mode.

Default value: `false`

##### `allowed_users`

Data type: `Array[String[1]]`

List of users that are specifically allowed to use `crontab(1)`.
If none are specified, all users are allowed.

Default value: [ ]

##### `denied_users`

Data type: `Array[String[1]]`

List of users that are specifically denied to use `crontab(1)`.

Default value: [ ]


### cron::config


### cron::install


### cron::purge


### cron::remove


### cron::service


## Defined types

### cron::job

#### Examples
##### Declaring cron jobs
```puppet
cron::job {
  'ping-host':
    command => '/usr/local/bin/my-host-pinger';
  'my-backup':
    command => '/usr/local/bin/my-backup',
    hour    => [ 0, 12 ],
    minute  => '*/10';
}
```


#### Parameters

The following parameters are available in the `cron::job` defined type.

##### `command`

Data type: `String`

Command path to be executed

##### `user`

Data type: `String`

The user who owns the cron job

Default value: 'root'

##### `minute`

Data type: `Cron::Minute`

Cron minute

Default value: '*'

##### `hour`

Data type: `Cron::Hour`

Cron hour

Default value: '*'

##### `monthday`

Data type: `Cron::Monthday`

Cron monthday

Default value: '*'

##### `month`

Data type: `Cron::Month`

Cron month

Default value: '*'

##### `weekday`

Data type: `Cron::Weekday`

Cron weekday

Default value: '*'


### cron::whitelist

#### Examples
##### Using cron::whitelist resource
```puppet
cron::whitelist { 'sample_name': }
```


## Functions

### cron::prep4cron
Type: Puppet Language

#### `cron::prep4cron(Variant[
    Cron::Minute,
    Cron::Hour,
    Cron::Monthday,
    Cron::Month,
    Cron::Weekday
  ] $cron_value = '*')`

cron::prep4cron function

This functions prepares any cron::job custom timing value to be
used as Puppet internal cron's resource argument

Returns: `String` Representation of the cron time value in a proper format suited for
internal Puppet's cron resource.

##### `cron_value`

Data type: `Variant[
    Cron::Minute,
    Cron::Hour,
    Cron::Monthday,
    Cron::Month,
    Cron::Weekday
  ]`

A variant of any of cron's internal timing structures (minute, hour, monthday, month, weekday)

