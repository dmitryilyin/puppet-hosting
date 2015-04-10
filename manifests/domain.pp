include 'hosting::params'

define hosting::domain(
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
  hosting::nginx { $title :
    domains       => $domains,
    user          => $user,
    group         => $group,
    override_root => $override_root,
  }

  hosting::apache { $title :
    domains       => $domains,
    user          => $user,
    group         => $group,

    php_execution_limit => $php_execution_limit,
    php_memory_limit => $php_memory_limit,
    php_upload_limit => $php_upload_limit,

    apache_cpu_limit => $apache_cpu_limit,
    apache_memory_limit => $apache_memory_limit,
    apache_nproc_limit => $apache_nproc_limit,
    apache_clients_limit => $apache_clients_limit,

    override_root  => $override_root,
    override_email => $override_email,
  }

  if !defined(Hosting::User[$user]) {
    hosting::user { $user :
    }
  }
}
