include 'hosting::params'

define hosting::apache (
  $web_root = $hosting::params::web_root,
  $port = $hosting::params::apache_port,
  $apache_server = $hosting::params::apache_server,
  $apache_port = $hosting::params::apache_port,
  $log_dir = $hosting::params::apache_log_dir,
  $conf_dir = $hosting::params::apache_conf_dir,
  $static_regexp = $hosting::params::static_regexp,
  $listen = $hosting::params::apache_listen,
  $web_group = $hosting::params::web_group,

  $php_execution_limit = $hosting::params::php_execution_limit,
  $php_memory_limit = $hosting::params::php_memory_limit,
  $php_upload_limit = $hosting::params::php_upload_limit,

  $apache_cpu_limit = $hosting::params::apache_cpu_limit,
  $apache_memory_limit = $hosting::params::apache_memory_limit,
  $apache_nproc_limit = $hosting::params::apache_nproc_limit,
  $apache_clients_limit = $hosting::params::apache_clients_limit,

  $domains = '',
  $override_root = undef,
  $override_email = undef,
  $user,
  $group,
) {

  $data_dir = 'data'
  $tmp_dir = 'tmp'
  $index_files = 'index.html index.php'

  $additional_domains = $domains
  $domain = $title

  $user_home_dir = "${web_root}/${user}"
  $user_data_dir = "${user_home_dir}/${data_dir}"
  $user_tmp_dir = "${user_home_dir}/${tmp_dir}" 
  $conf = "${conf_dir}/${domain}.conf"

  if $override_root {
    $root = $override_root
  } else {
    $root = "${user_data_dir}/${domain}"
  }

  if $override_email {
    $email = $override_email
  } else {
    $email = "admin@${domain}"
  }

  $sendmail_command = "/usr/sbin/sendmail -t -i -f ${email}"
  $cgi_bin_dir = "${root}/cgi-bin"

  file { "apache-${domain}.conf" :
    ensure  => 'present',
    path    => $conf,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('hosting/apache-domain.conf.erb'),
  }

  
  if !defined(File["user-${user}-tmp-dir"]) {
    file { "user-${user}-tmp-dir" :
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0640',
      path   => $user_tmp_dir,
    }
  }

  if !defined(File["user-${user}-data-dir"]) {
    file { "user-${user}-data-dir" :
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0644',
      path   => $user_data_dir,
    }
  }

  if !defined(File["user-${user}-home-dir"]) {
    file { "user-${user}-home-dir" :
      ensure => directory,
      owner  => $user,
      group  => $web_group,
      mode   => '0604',
      path   => $user_home_dir,
    }
  }

  file { "domain-${domain}-root-dir" :
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0644',
    path   => $root,
  }

  Hosting::User <| title == $user |> ~>
  Hosting::Apache[$domain] ~>
  Service <| title == 'apache' |>
}
