# This class handles cron service.
#
# @api private
class cron::service {
  if $cron::service_manage {
    service { 'cron':
      ensure     => $cron::service_ensure,
      enable     => $cron::service_enable,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
