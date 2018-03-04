# This class handles cron service.
#
# @api private
class cron::service {

  service { 'cron':
    ensure => running,
    enable => true,
  }

}
