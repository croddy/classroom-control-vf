
class profile::base {
# This is where you can declare classes for all nodes.
# Example:
# class { 'my_class': }
notify { "Hello, my name is ${::hostname}": }
$message = hiera('message')
notify { $message: }
}
