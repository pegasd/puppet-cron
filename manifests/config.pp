# Various cron configuration files
#
# @api private
class cron::config {

  if !empty($::cron::allowed_users) and !empty($::cron::denied_users) {
    fail('Either allowed or denied cron users must be specified, not both.')
  }

  file { '/etc/cron.deny':
    ensure  => unless empty($::cron::denied_users) { file } else { absent },
    force   => true,
    content => join(suffix($::cron::denied_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { '/etc/cron.allow':
    ensure  => if empty($::cron::denied_users) { file } else { absent },
    force   => true,
    content => join(suffix($::cron::allowed_users, "\n")),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
