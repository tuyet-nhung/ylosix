# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
ENV['RAILS_ENV'] = 'development' if ENV['RAILS_ENV'].nil? || ENV['RAILS_ENV'] == ''
#TODO add default RUBY version

puts "##### Environment => #{ENV['RAILS_ENV']}"

Vagrant.configure(2) do |config|

  config.vm.define 'main_app' do |app|
    app.vm.box = 'ubuntu/trusty32'
    app.vm.hostname = 'ecommerce-vm'

    app.vm.network 'forwarded_port', guest: 80, host: 13000 # Rails app

    app.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.memory = '1024'
    end

    app.vm.provider :digital_ocean do |provider, override|
      override.ssh.private_key_path = '~/.ssh/id_rsa'
      override.vm.box = 'digital_ocean'
      override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'

      provider.token = 'YOUR_TOKEN'
      provider.image = 'ubuntu-14-04-x64'
      provider.region = 'lon1'
      provider.size = '1gb'
    end

    config.vm.provider :managed_server do |managed, override|
      managed.server = 'example.com'
      override.ssh.username = 'username'
      override.ssh.private_key_path = '/path/to/user_name_private_key_path'
    end

    #TODO put this in the overrides.
    # install puppet provisioner for digital ocean provider or managed_server
    config.vm.provision 'shell', inline: 'apt-get install -y puppet'

    config.vm.provision :puppet do |puppet|
      puppet.facter = {
          'RAILS_ENV' => ENV['RAILS_ENV'] #TODO Check this not works parameter not exist
      }

      puppet.manifests_path = 'puppet/manifests'
      puppet.module_path = 'puppet/modules'
    end

    config.vm.provision 'shell', path: 'puppet/scripts/vagrant-init.sh', :args => ENV['RAILS_ENV']

    if ENV['RAILS_ENV'] == 'development'
      config.trigger.after :up do
        run "vagrant ssh -c 'sudo stop ecommerce'"
        run "vagrant ssh -c 'sudo start ecommerce'"
      end
    end
  end


  # config.vm.define 'docker_postgres' do |postgres|
  #   postgres.vm.provider 'docker' do |d|
  #     d.image  = 'abevoelker/postgres'
  #     d.name   = 'ecommerce_postgres'
  #     d.ports  = ['5432:5432']
  #   end
  # end
  #
  # config.vm.define 'docker_app' do |app|
  #
  #   app.vm.provider 'docker' do |d|
  #     d.image           = 'library/ubuntu:trusty'
  #     d.name            = 'ecommerce_rails'
  #     d.create_args     = ['-i', '-t']
  #     d.cmd             = ['/bin/bash', '-l']
  #     d.remains_running = false
  #     d.ports           = ['3000:3000']
  #
  #     d.link('ecommerce_postgres:docker_postgres')
  #   end
  # end

  config.vm.synced_folder '.', '/var/www'
end
