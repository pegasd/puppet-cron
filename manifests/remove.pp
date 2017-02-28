# @api private
# This class handles removal of all cron-related resources.
# Avoid modifying and using private classes directly.
class cron::remove {

  package { 'cron':
    ensure => absent,
  }

}
