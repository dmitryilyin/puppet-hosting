class hosting::service inherits hosting::params {
  
  service { 'nginx' :
    ensure => 'running',
    enable => true,
    name   => $nginx_service,
    hasrestart => true,
    hasstatus  => true,
  }

  service { 'apache' :
    ensure => 'running',
    enable => true,
    name   => $apache_service,
    hasrestart => true,
    hasstatus  => true,
  }

}
