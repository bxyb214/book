server '192.168.33.10', user: 'postgres', roles: %w{web app db}

set :ssh_options, {
  keys: '~/.vagrant.d/insecure_private_key'
}
