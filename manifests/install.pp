# This class handles cron packages.
#
# @api private
class cron::install {
  package { 'cron':
    ensure => $cron::package_version,
  }
}
