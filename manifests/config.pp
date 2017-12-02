# @api private
#
# Various cron configuration files
class cron::config {

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
