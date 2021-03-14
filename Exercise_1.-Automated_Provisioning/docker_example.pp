#puppet file created by Jorge Castilla
include 'docker'

docker::image { 'ubuntu':
   	image_tag => 'trusty',
}
docker::run { 'helloworld':
  	image   => 'ubuntu',
  	command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
}
docker::registry { 'example.github.io:5000':
# Extraido de: https://forge.puppet.com/modules/puppetlabs/docker
  	username => 'user_upload',
  	password => 'secret',
}

# Call to bash script  connectivity_check.sh
class scriptexec {
file {
	'bash_connectivity_check':
	ensure => 'file',
	source => 'puppet:///modules/ubuntu/connectivity_check.sh',
	path => '/usr/connectivity_check.sh',
	owner => 'root',
	group => 'root',
	mode  => '0744', # Use 0700 if it is sensitive
	notify => Exec[‘run_connectivity_check’],
}
exec {
	'run_connectivity_check’:
	command => '/usr/connectivity_check.sh'',
	refreshonly => true,
}
}

define docker::push