# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'open-call-workstation'
  config.vm.box = "ubuntu/trusty64"

  config.omnibus.chef_version = "12.5.1"
  config.berkshelf.enabled = true

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 9200, host: 9200

  config.vm.provider :virtualbox do |vb|
    vb.name = "OpenCall"
    vb.memory = "3072"
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'open_call' => {
        'ruby_gems' => [
          { 'bundler' => '1.9.1' },
          { 'foreman' => '0.78.0' }
        ]
      },
      'java' => {
        'install_flavor' => 'oracle',
        'jdk_version' => '8',
        'oracle' => { 'accept_oracle_download_terms' => true }
      },
      'postgresql' => {
        'version' => '9.3',
        'password' => { 'postgres' => '' },
        'pg_hba' => [
          {
            :type => 'local', 
            :db => 'all', 
            :user => 'all', 
            :addr => nil, 
            :method => 'trust'
          },
          {
            :type => 'host', 
            :db => 'all', 
            :user => 'all', 
            :addr => '127.0.0.1/32', 
            :method => 'trust'
          }
        ] 
      }
    }

    chef.run_list = [
      'recipe[open_call::default]',
      'recipe[open_call::repo]'
    ]
  end
end
