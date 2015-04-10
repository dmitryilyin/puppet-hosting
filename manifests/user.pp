define hosting::user(
) {
  $web_root = $hosting::params::web_root
  $web_group = $hosting::params::web_group
  $home = "${web_root}/${title}"

  user { $title :
    ensure     => present,
    home       => $home,
    gid        => $title,
    groups     => $web_group,
    managehome => true,
    membership => 'inclusive',
  }

}
