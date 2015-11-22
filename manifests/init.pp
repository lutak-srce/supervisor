#
# = Class: supervisor
#
# This modules installs and manages supervisor
#
class supervisor (
  $file_supervisord_conf     = 'puppet:///modules/supervisor/supervisord.conf',
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
    source  => $file_supervisord_conf,
    require => Package['supervisor'],
    notify  => Service['supervisord'],
  }

}
