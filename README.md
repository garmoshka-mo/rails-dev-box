# A Virtual Machine for Ruby on Rails

## Introduction

This project automates the setup of a development environment for working on Ruby on Rails.

## Requirements

First install two applications on your host machine:

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

1. Create folder `repos` at convenient location on your host machine. This will be the folder, where you will keep all your working repositories.
2. Open terminal, go into `repos` and execute following commands:

```
host$ git clone https://github.com/garmoshka-mo/rails-dev-box
host$ cd rails-dev-box
host$ vagrant up
```

That's it.

After the installation has finished, you can access the virtual machine with

    host$ vagrant ssh
    Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-55-generic x86_64)
    ...
    vagrant@rails-dev-box:~$ ls
	repos 
    ubuntu@rails-dev-box:~$ cd repos/
    ubuntu@rails-dev-box:~/repos$ ls
    rails-dev-box

This `~/repos` folder is mounted from your host machine. Here you will have all of your working repositories available from Virtual Machine and from host machine at same time.

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer. 

Rails version before 5 doesn't listen 0.0.0.0 by default. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces:

    bin/rails server -b 0.0.0.0
	
## Connect to database
	
To work with postgres database:
	
1. Download postgres UI for your OS (e.g. Postico for OsX)
2. Connect to host localhost:5432
3. Use login/password: `vagrant` / `vagrant`

## What's In The Box

* Development tools

* Git

* Ruby 2.3

* Bundler

* SQLite3, MySQL, and Postgres

* Databases and users needed to run the Active Record test suite

* System dependencies for nokogiri, sqlite3, mysql, mysql2, and pg

* Memcached

* Redis

* RabbitMQ

* An ExecJS runtime

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

Just clone your Rails fork into the rails-dev-box directory on the host computer:

    host $ ls
    bootstrap.sh MIT-LICENSE README.md Vagrantfile
    host $ git clone git@github.com:<your username>/rails.git

Vagrant mounts that directory as _/vagrant_ within the virtual machine:

    vagrant@rails-dev-box:~$ ls /vagrant
    bootstrap.sh MIT-LICENSE rails README.md Vagrantfile

Install gem dependencies in there:

    vagrant@rails-dev-box:~$ cd /vagrant/rails
    vagrant@rails-dev-box:/vagrant/rails$ bundle

We are ready to go to edit in the host, and test in the virtual machine.

This workflow is convenient because in the host computer you normally have your editor of choice fine-tuned, Git configured, and SSH keys in place.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.

## Faster Rails test suites

The default mechanism for sharing folders is convenient and works out the box in
all Vagrant versions, but there are a couple of alternatives that are more
performant.

### rsync

Vagrant 1.5 implements a [sharing mechanism based on rsync](https://www.vagrantup.com/blog/feature-preview-vagrant-1-5-rsync.html)
that dramatically improves read/write because files are actually stored in the
guest. Just throw

    config.vm.synced_folder '.', '/vagrant', type: 'rsync'

to the _Vagrantfile_ and either rsync manually with

    vagrant rsync

or run

    vagrant rsync-auto

for automatic syncs. See the post linked above for details.

### NFS

If you're using Mac OS X or Linux you can increase the speed of Rails test suites with Vagrant's NFS synced folders.

With an NFS server installed (already installed on Mac OS X), add the following to the Vagrantfile:

    config.vm.synced_folder '.', '/vagrant', type: 'nfs'
    config.vm.network 'private_network', ip: '192.168.50.4' # ensure this is available

Then

    host $ vagrant up

Please check the Vagrant documentation on [NFS synced folders](http://docs.vagrantup.com/v2/synced-folders/nfs.html) for more information.

## License

Released under the MIT License, Copyright (c) 2012–<i>ω</i> Xavier Noria.
