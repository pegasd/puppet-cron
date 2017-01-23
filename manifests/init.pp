# Cron class.
#
# @author Evgeny Piven <epiven@gmail.com>
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
  String[4, 4] $dir_mode   = '0755',
  Boolean      $use_incron = false,
) {

  file { '/etc/cron.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => $dir_mode,
  }

  if $use_incron {
    file { '/etc/incron.d':
      ensure  => directory,
      recurse => true,
      purge   => true,
      force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => $dir_mode,
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
