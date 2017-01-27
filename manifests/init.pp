# cron class
#
# @author Eugene Piven <epiven@gmail.com>
#
# @see https://github.com/pegasd/puppet-cron
#
# @example Declaring the cron class
#   include cron
#
# @param dir_mode /etc/cron.d directory mode
# @param use_incron Whether to also use incron.
#   Note: When this is off (by default!), the module will keep /etc/incron.d directory clean!
class cron (
  String[4, 4] $crond_mode   = '0755',
  String[4, 4] $incrond_mode = '0755',
  Boolean      $use_incron   = false,
) {

  file { '/etc/cron.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => $crond_mode,
  }

  if $use_incron {
    file { '/etc/incron.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => $incrond_mode,
    }

    package { 'incron':
      ensure => present,
    }

    service { 'incron':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['incron'],
    }
  } else {
    file { '/etc/incron.d':
      ensure => absent,
      force  => true,
    }

    package { 'incron':
      ensure => absent,
    }
  }

}
