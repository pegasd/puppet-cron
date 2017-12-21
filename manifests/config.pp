# @api private
#
# Various cron configuration files
class cron::config {

  if !empty($::cron::allowed_users) and !empty($::cron::denied_users) {
    fail('Either allowed or denied cron users must be specified, not both.')
  }

  if !empty($::cron::allowed_users) {
    $ensure_allow = file
    $ensure_deny = absent
  } elsif !empty($::cron::denied_users) {
    $ensure_allow = absent
    $ensure_deny = file
  } else {
    $ensure_allow = absent
    $ensure_deny = absent
  }

  file { '/etc/cron.deny':
    ensure  => $ensure_deny,
    force   => true,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/cron.allow':
    ensure  => $ensure_allow,
    force   => true,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
