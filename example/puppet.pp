# You need
# mod 'garethr-docker', '5.3.0'
# for this to work

$internal_ip=$::ec2_local_ipv4 # on AWS this works
$environment='qa'
$role='client'
$cluster='es5'
$target_url='consul://consul-dns:80'

docker::run { 'registrator':
  image            => 'gliderlabs/registrator:master',
  net              => 'host',
  volumes          => [
    '/var/run/docker.sock:/tmp/docker.sock ',
  ],
  restart_service  => true,
  privileged       => false,
  pull_on_start    => true,
  command          => "-cleanup -deregister=always -ip=${::ec2_local_ipv4} -ttl=180 -ttl-refresh=60 -resync=60 -tags env-${environment},role-${role},cluster-${cluster} '${target_url}'",
  extra_parameters => [
    '--sig-proxy=false',
  ],
}
