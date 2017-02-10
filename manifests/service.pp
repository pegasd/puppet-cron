# @api private
# This class handles cron service.
# Avoid modifying and using private classes directly.
class cron::service {

  service { 'cron':
    ensure => running,
    enable => true,
  }

}