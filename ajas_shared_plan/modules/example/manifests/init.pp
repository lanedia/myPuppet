#
# Example module
#
class example (
  $boolean_parameter = undef,
  $string_parameter = undef,
) {
  file { '/etc/example_product.conf':
    ensure  => present,
    content => template('example/conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }
}
