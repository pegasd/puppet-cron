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
# @param package_version Custom `cron` package version.
# @param allowed_users List of users allowed to use `crontab(1)`. By default, only root can.
# @param denied_users List of users specifically denied to use `crontab(1)`.
#   Note: When this is not empty, all users except ones specified here will be able to use `crontab`.
# @param service_manage Whether to manage cron service at all.
# @param service_ensure Cron service's `ensure` parameter.
# @param service_enable Cron service's `enable` parameter.
# @param purge_cron Whether to purge crontab entries.
# @param purge_crond Also purge unmanaged files in `/etc/cron.d` directory.
# @param purge_noop Run purging in `noop` mode.
class cron (
  Enum[present, absent]  $ensure          = present,

  # cron::install
  String[1]              $package_version = installed,

  # cron::config
  Array[String[1]]       $allowed_users   = [ ],
  Array[String[1]]       $denied_users    = [ ],

  # cron::service
  Boolean                $service_manage  = true,
  Enum[running, stopped] $service_ensure  = running,
  Boolean                $service_enable  = true,

  # cron::purge
  Boolean                $purge_cron      = true,
  Boolean                $purge_crond     = false,
  Boolean                $purge_noop      = false,
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
