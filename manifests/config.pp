# @api private
#
# Various cron configuration files
class cron::config {

  if !empty($::cron::allowed_users) and !empty($::cron::denied_users) {
    fail('Either allowed or denied cron users must be specified, not both.')
  }

  file { '/etc/cron.deny':
    ensure => absent,
    force  => true,
  }

  file { '/etc/cron.allow':
    ensure  => file,
    content => '',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
