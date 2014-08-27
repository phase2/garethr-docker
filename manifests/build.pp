define docker::build (
  $directory,
  $image_tag = $title,
  $force_rm = false,
  $no_cache = false,
  $quiet = false,
  $rm = true,
) {
  $docker_command = $::docker::params::docker_command

  # Parameter validation
  validate_bool($force_rm)
  validate_bool($no_cache)
  validate_bool($quiet)
  validate_bool($rm)
  validate_absolute_path($directory)
  validate_re($image_tag, '^[\S/]*$')

  exec { "build ${image_tag} container":
    path    => ['/bin', '/usr/bin'],
    command => "${docker_command} build --force-rm=${force_rm} --no-cache=${no_cache} --quiet=${quiet} --rm=${rm} --tag=\"${image_tag}\" ${directory}",
    require => Class['::docker'],
  }
}
