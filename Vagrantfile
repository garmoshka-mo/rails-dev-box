# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/wily64'
  config.vm.hostname = 'rails-dev-box'

  config.vm.network :forwarded_port, host: 3000, guest: 3000
  config.vm.network :forwarded_port, host: 3001, guest: 3001
  config.vm.network :forwarded_port, host: 3808, guest: 3808
  config.vm.network :forwarded_port, host: 3306, guest: 3306
  config.vm.network :forwarded_port, host: 8080, guest: 8080
  config.vm.network :forwarded_port, host: 5000, guest: 5000
  config.vm.network :forwarded_port, host: 8082, guest: 8082
  config.vm.network :forwarded_port, host: 9000, guest: 9000
  config.vm.network :forwarded_port, host: 9292, guest: 9292

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  config.vm.synced_folder "../", "/home/vagrant/repos"
  config.vm.synced_folder "../../temp/", "/home/vagrant/temp"

  config.vm.provider 'virtualbox' do |v|
    v.memory = 512
    v.cpus = 2
  end
end
