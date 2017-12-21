# cron class
#
# This is the main entry point into all cron-related resources on
# the host. And because of its "tidiness", be very careful to manage evertyhing
# that is needed through this class and related resources.
#
# @author Eugene Piven <epiven@gmail.com>
#
# @see https://github.com/pegasd/puppet-cron
#
# @example Declaring the cron class
#   include cron
#
# @example Also purge unmanaged files in /etc/cron.d directory
#   class { 'cron': purge_crond => true }
#
# @example Removing all cron-related resources from the system
#   class { 'cron': ensure => absent }
#
# @param ensure Whether to enable or disable cron on the system.
# @param purge_crond Also purge unmanaged files in /etc/cron.d directory
# @param purge_noop Run purging in `noop` mode.
class cron (
  Enum[present, absent] $ensure        = present,
  Boolean               $purge_crond   = false,
  Boolean               $purge_noop    = false,
  Array[String[1]]      $allowed_users = [ ],
  Array[String[1]]      $denied_users  = [ ],
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
