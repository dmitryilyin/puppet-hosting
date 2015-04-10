class hosting::params {

  $web_root = '/var/www'
  $apache_conf_dir = '/etc/httpd/domains'
  $nginx_conf_dir = '/etc/nginx/domains'
  $nginx_port = '80'
  $apache_port = '8080'
  $nginx_log_dir = '/var/log/nginx'
  $apache_log_dir = '/var/log/httpd'
  $nginx_user = 'nginx'
  $nginx_group = 'nginx'
  $apache_user = 'apache'
  $apache_group = 'apache'
  $static_regexp = '^.+\.(jpg|jpeg|gif|png|svg|js|css|mp3|ogg|mpe?g|avi|zip|gz|bz2?|rar)$'

  $apache_server = '127.0.0.1'
  $data_dir = 'data'
  $apache_listen = '*'

  $apache_service = 'httpd'
  $nginx_service = 'nginx'
  $web_group = 'web'

  $php_execution_limit = '30'
  $php_memory_limit = '268435456'
  $php_upload_limit = '20971520'
  $apache_cpu_limit = '30'
  $apache_memory_limit = '268435456'
  $apache_nproc_limit = '30'
  $apache_clients_limit = '30'
}
