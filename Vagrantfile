# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/xenial64'
  config.vm.hostname = 'rails-dev-box'

  config.vm.network :forwarded_port, host: 3000, guest: 3000
  config.vm.network :forwarded_port, host: 3001, guest: 3001
  config.vm.network :forwarded_port, host: 3808, guest: 3808
  config.vm.network :forwarded_port, host: 3306, guest: 3306
  config.vm.network :forwarded_port, host: 5432, guest: 5432
  config.vm.network :forwarded_port, host: 6379, guest: 6379
  config.vm.network :forwarded_port, host: 8082, guest: 8082
  config.vm.network :forwarded_port, host: 9000, guest: 9000
  config.vm.network :forwarded_port, host: 9292, guest: 9292
  config.vm.network :forwarded_port, host: 9292, guest: 9292
  config.vm.network :forwarded_port, host: 35729, guest: 35729 # guard-livereload

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  config.vm.synced_folder "../", "/home/ubuntu/repos", fsnotify: true
  config.vm.synced_folder "../../Documents/temp", "/home/ubuntu/temp", fsnotify: true

  config.vm.provider 'virtualbox' do |v|
    v.memory = 512
    v.cpus = 2
    v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  end

  config.ssh.forward_agent = true

end
