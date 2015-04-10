class hosting::base inherits hosting::params {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { 'nginx_log_dir' :
    ensure => directory,
    path   => $nginx_log_dir,
    owner  => $nginx_user,
    group  => $nginx_group,
  }

  file { 'apache_log_dir' :
    ensure => directory,
    path   => $apache_log_dir,
  }

  file { 'nginx_conf_dir' :
    ensure => directory,
    path   => $nginx_conf_dir,
  }

  file { 'apache_conf_dir' :
    ensure => directory,
    path   => $apache_conf_dir,
  }
}
