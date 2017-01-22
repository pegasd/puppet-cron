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
class cron (
  String[4, 4] $dir_mode = '0755',
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

}
