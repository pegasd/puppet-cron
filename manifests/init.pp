# cron class
#
# This is the main entry point into all cron- and incron-related resources on
# the host. And because of its "tidiness", be very careful to manage evertyhing
# that is needed through this class and related resources.
#
# @author Eugene Piven <epiven@gmail.com>
#
# @see https://github.com/pegasd/puppet-cron
#
# @example Declaring the cron class
#   include cron
#
# @param crond_mode /etc/cron.d directory permissions
# @param incrond_mode /etc/incron.d directory permissions
# @param use_incron Whether to also use incron
class cron (
  String[4, 4] $crond_mode   = '0755',
  String[4, 4] $incrond_mode = '0755',
  Boolean      $use_incron   = false,
) {

  Class['cron'] -> Cron::Job <| |>
  Class['cron'] -> Cron::Incron_job <| |>

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
