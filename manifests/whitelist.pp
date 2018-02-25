# Use this to whitelist any system cron jobs you don't want this module to touch.
# This will make sure `/etc/cron.d/${title}` won't get deleted or modified.
#
# @example Using cron::whitelist resource
#   cron::whitelist { 'sample_name': }
define cron::whitelist {

  require ::cron

  file { "/etc/cron.d/${title}":
    ensure  => file,
    replace => false,
  }

}
