include 'hosting::params'

define hosting::nginx(
  $web_root = $hosting::params::web_root,
  $port = $hosting::params::nginx_port,
  $apache_server = $hosting::params::apache_server,
  $apache_port = $hosting::params::apache_port,
  $log_dir = $hosting::params::nginx_log_dir,
  $conf_dir = $hosting::params::nginx_conf_dir,
  $static_regexp = $hosting::params::static_regexp,

  $domains = '',
  $override_root = undef,
  $user,
  $group,
) {

  $domain = $title
  $additional_domains = $domains
  $data_dir = 'data'

  $conf = "${conf_dir}/${domain}.conf"
  
  if $override_root {
    $root = $override_root
  } else {
    $root = "${web_root}/${user}/${data_dir}/${domain}"
  }

  file { "nginx-${domain}.conf" :
    ensure  => 'present',
    path    => $conf,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('hosting/nginx-domain.conf.erb'),
  }

  Hosting::User <| title == $user |> -> Hosting::Nginx[$title]
  Hosting::Nginx[$title] ~> Service <| title == 'nginx' |>
  Hosting::Nginx[$title] -> Hosting::Apache[$title]
}
