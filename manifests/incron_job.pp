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
# @param command Command to execute on triggered event
# @param event inotify event (either 'IN_CLOSE_WRITE' or 'IN_MOVED_TO')
# @param path Path to watched directory
# @param mode Incron job file permissions, which is located at /etc/incron.d/JOB_NAME
define cron::incron_job (
  String                                $command,
  Enum['IN_CLOSE_WRITE', 'IN_MOVED_TO'] $event,
  Stdlib::Unixpath                      $path,
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
