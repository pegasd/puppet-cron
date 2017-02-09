# @api private
# This class handles cron packages.
# Avoid modifying and using private classes directly.
class cron::install {

  package { 'cron':
    ensure => present,
  }

}
