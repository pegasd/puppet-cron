# incron job resource
#
# @author Eugene Piven <epiven@gmail.com>
#
# @example Declaring incron job
#   cron::incron_job { 'process_file':
#     path    => '/storage/incoming/upload',
#     event   => 'IN_CLOSE_WRITE',
#     command => '/usr/local/bin/process_file',
#   }
#
# @param path Path to watched directory
# @param event inotify event (either 'IN_CLOSE_WRITE' or 'IN_MOVED_TO')
# @param command Command to execute on triggered event
define cron::incron_job (
  Stdlib::Unixpath                      $path,
  Enum['IN_CLOSE_WRITE', 'IN_MOVED_TO'] $event,
  String                                $command,
  String[4, 4]                          $mode = '0644',
) {

  require ::cron

  file { "/etc/incron.d/${title}":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => $mode,
    content => epp('cron/incron_job.epp', {
      name    => $title,
      path    => $path,
      event   => $event,
      command => $command,
    })
  }

}