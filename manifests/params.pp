#
# = Class: supervisor::params
#
# This module contains defaults for tsm modules
#
class supervisor::params {

  $ensure           = 'present'
  $version          = undef
  $status           = 'enabled'
  $autorestart      = true
  $dependency_class = '::supervisor::dependency'
  $my_class         = undef

  # install package depending on major version
  case $::osfamily {
    default: {}
    /(RedHat|redhat|amazon|Debian|debian|Ubuntu|ubuntu)/: {
      $unix_http_server_file = '/var/run/supervisor/supervisor.sock'
    }
    #/(Debian|debian)/: {
    #}
  }

}
