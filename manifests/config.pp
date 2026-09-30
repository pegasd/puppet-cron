# Various cron configuration files
#
# @api private
class cron::config {
  if !empty($cron::allowed_users) and !empty($cron::denied_users) {
    fail('Either allowed or denied cron users must be specified, not both.')
  }

  # On FreeBSD cron.allow governs root too, so an empty allow file would lock
  # root out; keep root listed there (see $cron::allow_root).
  $allowed_users = $cron::allow_root ? {
    true    => unique(['root'] + $cron::allowed_users),
    default => $cron::allowed_users,
  }

  file {
    default:
      force => true,
      owner => 'root',
      group => $cron::root_group,
      mode  => '0644';
    $cron::allow_file:
      ensure  => if (!$cron::allow_all_users and empty($cron::denied_users)) { file } else { absent },
      content => join(suffix($allowed_users, "\n"));
    $cron::deny_file:
      ensure  => unless empty($cron::denied_users) { file } else { absent },
      content => join(suffix($cron::denied_users, "\n"));
  }
}
