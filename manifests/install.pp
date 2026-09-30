# This class handles cron packages.
#
# @api private
class cron::install {
  if $cron::manage_package {
    package { 'cron':
      ensure => $cron::package_version,
    }
  }
}
