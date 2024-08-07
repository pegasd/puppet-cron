# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

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

* [`cron::job`](#cron--job): Cron job defined type with a bit of magic dust sprinkled all over.
* [`cron::job::daily`](#cron--job--daily): Manage daily cron jobs.
* [`cron::job::hourly`](#cron--job--hourly): Manage hourly cron jobs.
* [`cron::job::monthly`](#cron--job--monthly): Manage weekly cron jobs.
* [`cron::job::weekly`](#cron--job--weekly): Manage weekly cron jobs.
* [`cron::whitelist`](#cron--whitelist): Use this to whitelist any system cron jobs you don't want this module to touch. This will make sure `/etc/cron.d/${title}` won't get deleted 

### Data types

* [`Cron::Command`](#Cron--Command): Used for `cron::job::command` parameter. Does not allow newline characters (which breaks crontab).
* [`Cron::Ensure`](#Cron--Ensure): A simple ensure enum
* [`Cron::Hour`](#Cron--Hour): Stricter `cron::job::hour`.
* [`Cron::Minute`](#Cron--Minute): Stricter `cron::job::minute`.
* [`Cron::Month`](#Cron--Month): Stricter `cron::job::month`.
* [`Cron::Monthday`](#Cron--Monthday): Sricter `cron::job::monthday`.
* [`Cron::User`](#Cron--User): Cron user.
* [`Cron::Weekday`](#Cron--Weekday): Stricter `cron::job::weekday`.

## Classes

### <a name="cron"></a>`cron`

Main entry point into all cron-related resources on
the host.
It purges by default. You've been warned!

* **See also**
  * manpages
    * crontab(1), crontab(5), cron(8)

#### Examples

##### Declaring the cron class

```puppet
include cron
```

##### Also purge unmanaged files in /etc/cron.d directory

```puppet
class { 'cron':
  purge_crond => true,
}
```

##### Removing all cron-related resources from the system

```puppet
class { 'cron':
  ensure => absent,
}
```

##### Deny `crontab(1)` usage to all users except 'luke' (and 'root' - he can always do that).

```puppet
class { 'cron':
  allowed_users => [ 'luke' ],
}
```

#### Parameters

The following parameters are available in the `cron` class:

* [`ensure`](#-cron--ensure)
* [`package_version`](#-cron--package_version)
* [`allow_all_users`](#-cron--allow_all_users)
* [`allowed_users`](#-cron--allowed_users)
* [`denied_users`](#-cron--denied_users)
* [`service_manage`](#-cron--service_manage)
* [`service_ensure`](#-cron--service_ensure)
* [`service_enable`](#-cron--service_enable)
* [`purge_cron`](#-cron--purge_cron)
* [`purge_crond`](#-cron--purge_crond)
* [`purge_noop`](#-cron--purge_noop)

##### <a name="-cron--ensure"></a>`ensure`

Data type: `Enum[present, absent]`

Whether to enable or disable cron on the system.

Default value: `present`

##### <a name="-cron--package_version"></a>`package_version`

Data type: `Pattern[/\A[^\n]+\z/]`

Custom `cron` package version.

Default value: `installed`

##### <a name="-cron--allow_all_users"></a>`allow_all_users`

Data type: `Boolean`

Allow all users to manage crontab.

Default value: `false`

##### <a name="-cron--allowed_users"></a>`allowed_users`

Data type: `Array[Cron::User]`

List of users allowed to use `crontab(1)`. By default, only root can.

Default value: `[]`

##### <a name="-cron--denied_users"></a>`denied_users`

Data type: `Array[Cron::User]`

List of users specifically denied to use `crontab(1)`.
Note: When this is not empty, all users except ones specified here will be able to use `crontab`.

Default value: `[]`

##### <a name="-cron--service_manage"></a>`service_manage`

Data type: `Boolean`

Whether to manage cron service at all.

Default value: `true`

##### <a name="-cron--service_ensure"></a>`service_ensure`

Data type: `Enum[running, stopped]`

Cron service's `ensure` parameter.

Default value: `running`

##### <a name="-cron--service_enable"></a>`service_enable`

Data type: `Boolean`

Cron service's `enable` parameter.

Default value: `true`

##### <a name="-cron--purge_cron"></a>`purge_cron`

Data type: `Boolean`

Whether to purge crontab entries.

Default value: `true`

##### <a name="-cron--purge_crond"></a>`purge_crond`

Data type: `Boolean`

Also purge unmanaged files in `/etc/cron.d` directory.

Default value: `false`

##### <a name="-cron--purge_noop"></a>`purge_noop`

Data type: `Boolean`

Run purging in `noop` mode.

Default value: `false`

## Defined types

### <a name="cron--job"></a>`cron::job`

Cron job defined type with a bit of magic dust sprinkled all over.

#### Examples

##### Consider cron job declaration using built-in type

```puppet
cron { 'my_job':
  minute => 0,
  hour   => 3,
}
```

##### This differs in that it manages *all* time values by default

```puppet
cron::job { 'my_job':
  minute => 0,
  hour   => 3,
}
```

##### Simple cron job that runs every minute

```puppet
cron::job { 'ping-host':
  command => '/usr/local/bin/my-host-pinger',
}
```

##### More advanced declaration

```puppet
cron::job { 'my-backup':
  command => '/usr/local/bin/my-backup',
  hour    => [ 0, 12 ],
  minute  => '*/10';
}
```

#### Parameters

The following parameters are available in the `cron::job` defined type:

* [`command`](#-cron--job--command)
* [`ensure`](#-cron--job--ensure)
* [`user`](#-cron--job--user)
* [`minute`](#-cron--job--minute)
* [`hour`](#-cron--job--hour)
* [`monthday`](#-cron--job--monthday)
* [`month`](#-cron--job--month)
* [`weekday`](#-cron--job--weekday)

##### <a name="-cron--job--command"></a>`command`

Data type: `Cron::Command`

Command path to be executed

##### <a name="-cron--job--ensure"></a>`ensure`

Data type: `Cron::Ensure`

Cron job state

Default value: `present`

##### <a name="-cron--job--user"></a>`user`

Data type: `Cron::User`

The user who owns the cron job

Default value: `'root'`

##### <a name="-cron--job--minute"></a>`minute`

Data type: `Cron::Minute`

Cron minute

Default value: `'*'`

##### <a name="-cron--job--hour"></a>`hour`

Data type: `Cron::Hour`

Cron hour

Default value: `'*'`

##### <a name="-cron--job--monthday"></a>`monthday`

Data type: `Cron::Monthday`

Cron monthday

Default value: `'*'`

##### <a name="-cron--job--month"></a>`month`

Data type: `Cron::Month`

Cron month

Default value: `'*'`

##### <a name="-cron--job--weekday"></a>`weekday`

Data type: `Cron::Weekday`

Cron weekday

Default value: `'*'`

### <a name="cron--job--daily"></a>`cron::job::daily`

Manage daily cron jobs.

#### Parameters

The following parameters are available in the `cron::job::daily` defined type:

* [`command`](#-cron--job--daily--command)
* [`ensure`](#-cron--job--daily--ensure)
* [`minute`](#-cron--job--daily--minute)
* [`hour`](#-cron--job--daily--hour)
* [`user`](#-cron--job--daily--user)

##### <a name="-cron--job--daily--command"></a>`command`

Data type: `Cron::Command`

Command path to be executed

##### <a name="-cron--job--daily--ensure"></a>`ensure`

Data type: `Cron::Ensure`

Cron job state

Default value: `present`

##### <a name="-cron--job--daily--minute"></a>`minute`

Data type: `Cron::Minute`

Cron minute

Default value: `0`

##### <a name="-cron--job--daily--hour"></a>`hour`

Data type: `Cron::Hour`

Cron hour

Default value: `0`

##### <a name="-cron--job--daily--user"></a>`user`

Data type: `Cron::User`

The user who owns the cron job

Default value: `'root'`

### <a name="cron--job--hourly"></a>`cron::job::hourly`

Manage hourly cron jobs.

#### Parameters

The following parameters are available in the `cron::job::hourly` defined type:

* [`command`](#-cron--job--hourly--command)
* [`ensure`](#-cron--job--hourly--ensure)
* [`minute`](#-cron--job--hourly--minute)
* [`user`](#-cron--job--hourly--user)

##### <a name="-cron--job--hourly--command"></a>`command`

Data type: `Cron::Command`

Command path to be executed

##### <a name="-cron--job--hourly--ensure"></a>`ensure`

Data type: `Cron::Ensure`

Cron job state

Default value: `present`

##### <a name="-cron--job--hourly--minute"></a>`minute`

Data type: `Cron::Minute`

Cron minute

Default value: `0`

##### <a name="-cron--job--hourly--user"></a>`user`

Data type: `Cron::User`

The user who owns the cron job

Default value: `'root'`

### <a name="cron--job--monthly"></a>`cron::job::monthly`

Manage weekly cron jobs.

#### Parameters

The following parameters are available in the `cron::job::monthly` defined type:

* [`command`](#-cron--job--monthly--command)
* [`ensure`](#-cron--job--monthly--ensure)
* [`minute`](#-cron--job--monthly--minute)
* [`hour`](#-cron--job--monthly--hour)
* [`monthday`](#-cron--job--monthly--monthday)
* [`user`](#-cron--job--monthly--user)

##### <a name="-cron--job--monthly--command"></a>`command`

Data type: `Cron::Command`

Command path to be executed

##### <a name="-cron--job--monthly--ensure"></a>`ensure`

Data type: `Cron::Ensure`

Cron job state

Default value: `present`

##### <a name="-cron--job--monthly--minute"></a>`minute`

Data type: `Cron::Minute`

Cron minute

Default value: `0`

##### <a name="-cron--job--monthly--hour"></a>`hour`

Data type: `Cron::Hour`

Cron hour

Default value: `0`

##### <a name="-cron--job--monthly--monthday"></a>`monthday`

Data type: `Cron::Monthday`

Cron monthday

Default value: `1`

##### <a name="-cron--job--monthly--user"></a>`user`

Data type: `Cron::User`

The user who owns the cron job

Default value: `'root'`

### <a name="cron--job--weekly"></a>`cron::job::weekly`

Manage weekly cron jobs.

#### Parameters

The following parameters are available in the `cron::job::weekly` defined type:

* [`command`](#-cron--job--weekly--command)
* [`ensure`](#-cron--job--weekly--ensure)
* [`minute`](#-cron--job--weekly--minute)
* [`hour`](#-cron--job--weekly--hour)
* [`weekday`](#-cron--job--weekly--weekday)
* [`user`](#-cron--job--weekly--user)

##### <a name="-cron--job--weekly--command"></a>`command`

Data type: `Cron::Command`

Command path to be executed

##### <a name="-cron--job--weekly--ensure"></a>`ensure`

Data type: `Cron::Ensure`

Cron job state

Default value: `present`

##### <a name="-cron--job--weekly--minute"></a>`minute`

Data type: `Cron::Minute`

Cron minute

Default value: `0`

##### <a name="-cron--job--weekly--hour"></a>`hour`

Data type: `Cron::Hour`

Cron hour

Default value: `0`

##### <a name="-cron--job--weekly--weekday"></a>`weekday`

Data type: `Cron::Weekday`

Cron weekday

Default value: `0`

##### <a name="-cron--job--weekly--user"></a>`user`

Data type: `Cron::User`

The user who owns the cron job

Default value: `'root'`

### <a name="cron--whitelist"></a>`cron::whitelist`

Use this to whitelist any system cron jobs you don't want this module to touch.
This will make sure `/etc/cron.d/${title}` won't get deleted or modified.

#### Examples

##### Using cron::whitelist resource

```puppet
cron::whitelist { 'sample_name': }
```

## Data types

### <a name="Cron--Command"></a>`Cron::Command`

Used for `cron::job::command` parameter.
Does not allow newline characters (which breaks crontab).

Alias of `Pattern[/\A[^\n]+\z/]`

### <a name="Cron--Ensure"></a>`Cron::Ensure`

A simple ensure enum

Alias of `Enum[present, absent]`

### <a name="Cron--Hour"></a>`Cron::Hour`

Stricter `cron::job::hour`.

Alias of

```puppet
Variant[Integer[0, 23], Array[Variant[
    Integer[0, 23],
    # Ranges like '0-12', '5-8', etc.
    Pattern[/\A(1?\d|2[0-3])-(1?\d|2[0-3])\z/],
    # Constructs like '*/5', '*/2'
    Pattern[/\A\*\/(1?\d|2[0-3])\z/],
  ], 2], Pattern[/\A(\*|(1?[0-9]|2[0-3])-(1?[0-9]|2[0-3]))(\/([2-9]|1[0-9]|2[0-3]))?\z/]]
```

### <a name="Cron--Minute"></a>`Cron::Minute`

Stricter `cron::job::minute`.

Alias of

```puppet
Variant[Integer[0, 59], Array[Variant[
    Integer[0, 59],
    # Ranges like '0-37', '30-59', etc.
    Pattern[/\A[0-5]?\d-[0-5]?\d\z/],
    # Patterns like '*/2'
    Pattern[/\A\*\/([2-9]|[1-5]\d)\z/],
  ], 2], Pattern[/\A(\*|[0-5]?\d-[0-5]?\d)(\/([2-9]|[1-5]\d))?\z/]]
```

### <a name="Cron--Month"></a>`Cron::Month`

Stricter `cron::job::month`.

Alias of `Variant[Integer[1, 12], Array[Integer[1, 12], 2], Pattern[/\A\*(\/([2-9]|1[0-1]))?\z/]]`

### <a name="Cron--Monthday"></a>`Cron::Monthday`

Sricter `cron::job::monthday`.

Alias of `Variant[Integer[1, 31], Array[Integer[1, 31], 2], Pattern[/\A\*(\/([2-9]|[1-2][0-9]|30))?\z/]]`

### <a name="Cron--User"></a>`Cron::User`

Cron user.

Alias of `Pattern[/\A\w[a-z0-9_-]{0,31}\z/]`

### <a name="Cron--Weekday"></a>`Cron::Weekday`

Stricter `cron::job::weekday`.

Alias of `Variant[Integer[0, 6], Array[Integer[0, 6], 2], Pattern[/\A(\*|[0-6]-[0-6])(\/[2-6])?\z/]]`

