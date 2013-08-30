define php::extension(
  $ensure,
  $package,
  $provider,
  $pipe = undef,
  $source = undef
) {

  if $provider == 'pecl' {
    package { $package:
      ensure   => $ensure,
      provider => $provider,
      pipe     => $pipe;
    }
  } else {
    package { $package:
      ensure   => $ensure,
      provider => $provider;
    }
  }

}
