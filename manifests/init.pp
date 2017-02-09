# cron class
#
# This is the main entry point into all cron- and incron-related resources on
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
#   class { 'cron': dir_mode = 0700 }
#
# @param ensure Whether to enable or disable cron on the system.
# @param dir_mode Permissions for /etc/cron.d directory.
class cron (
  Enum[present, absent]   $ensure   = present,
  Pattern[/^07[057]{2}$/] $dir_mode = '0755',
) {


  if $ensure == present {

    contain cron::install
    contain cron::config
    contain cron::service

    Class['::cron::install'] ->
    Class['::cron::config'] ~>
    Class['::cron::service']

  } else {

    contain cron::remove

  }

}
