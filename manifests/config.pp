# @api private
# This is where all the magic happens.
# Purge unmanaged cron jobs and also, optionally, purge /etc/cron.d directory
class cron::config {

  resources { 'cron':
    purge => true,
  }

}
