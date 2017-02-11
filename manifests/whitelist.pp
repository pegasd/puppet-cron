# cron::whitelist resource
#
# Use it to whitelist any system cron jobs you don't want this module to touch.
# This will make sure /etc/cron.d/JOB_NAME won't get deleted or modified.
#
# @example Using cron::whitelist resource
#   cron::whitelist { 'sample_name': }
define cron::whitelist {

  require ::cron

  file { "/etc/cron.d/${name}":
    ensure  => file,
    replace => false,
  }

}
