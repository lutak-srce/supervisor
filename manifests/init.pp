# @summary
#   Installs supervisord and starts daemon
#
# @param template
#   Path to ERB template for main config file
class supervisor (
  String $template               = 'supervisor/supervisord.conf.erb',
  Optional[String] $socket_owner = undef,
  Optional[String] $socket_group = undef,
  Optional[String] $socket_mode  = undef,
) inherits supervisor::params {

  package { 'supervisor':
    ensure => installed,
  }  

  service { 'supervisord':
    ensure  => running,
    enable  => true,
    require => Package['supervisor'],
  }  

  file { '/etc/supervisord.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template($template),
    require => Package['supervisor'],
    notify  => Service['supervisord'],
  }

  file { '/var/run/supervisor':
    ensure => directory,
    owner  => $socket_owner,
    group  => $socket_group,
    mode   => $socket_mode,
    notify => Package['supervisor'],
  }

}
