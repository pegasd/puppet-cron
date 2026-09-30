# Various cron configuration files
#
# @api private
class cron::config {
  if !empty($cron::allowed_users) and !empty($cron::denied_users) {
    fail('Either allowed or denied cron users must be specified, not both.')
  }

  file {
    default:
      force => true,
      owner => 'root',
      group => $cron::root_group,
      mode  => '0644';
    $cron::allow_file:
      ensure  => if (!$cron::allow_all_users and empty($cron::denied_users)) { file } else { absent },
      content => join(suffix($cron::allowed_users, "\n"));
    $cron::deny_file:
      ensure  => unless empty($cron::denied_users) { file } else { absent },
      content => join(suffix($cron::denied_users, "\n"));
  }
}
