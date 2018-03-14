# Main entry point into all cron-related resources on
# the host.
# It purges by default. You've been warned!
#
# @see manpages crontab(1), crontab(5), cron(8)
#
# @example Declaring the cron class
#   include cron
#
# @example Also purge unmanaged files in /etc/cron.d directory
#   class { 'cron':
#     purge_crond => true,
#   }
#
# @example Removing all cron-related resources from the system
#   class { 'cron':
#     ensure => absent,
#   }
#
# @example Deny `crontab(1)` usage to all users except 'luke' (and 'root' - he can always do that).
#   class { 'cron':
#     allowed_users => [ 'luke' ],
#   }
#
# @param ensure Whether to enable or disable cron on the system.
# @param purge_crond Also purge unmanaged files in `/etc/cron.d` directory.
# @param purge_noop Run purging in `noop` mode.
# @param allowed_users List of users that are specifically allowed to use `crontab(1)`.
#   If none are specified, all users are allowed.
# @param denied_users List of users that are specifically denied to use `crontab(1)`.
class cron (
  Enum[present, absent] $ensure          = present,
  Boolean               $purge_crond     = false,
  Boolean               $purge_noop      = false,
  Array[String[1]]      $allowed_users   = [ ],
  Array[String[1]]      $denied_users    = [ ],
  String[1]             $package_version = installed,
) {

  if $ensure == present {

    contain cron::install
    contain cron::config
    contain cron::service

    contain cron::purge

    Class['::cron::install'] -> Class['::cron::service'] -> Class['::cron::purge']
    Class['::cron::install'] ~> Class['::cron::service']

  } else {

    contain cron::remove

  }

}
