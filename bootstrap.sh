# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo adding swap file
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

# Safe poweroff
mv /sbin/poweroff /sbin/real_poweroff
echo 'echo are you sure?
read x
if [ "$x" = "yes" ]
then
  /sbin/real_poweroff
fi
' > /sbin/poweroff
chmod a+x /sbin/poweroff

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install Ruby ruby2.3 ruby2.3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Redis redis-server

# Postgres
install PostgreSQL postgresql postgresql-contrib libpq-dev

sudo -u postgres createuser --superuser vagrant
sudo -u postgres createdb vagrant
sudo -u postgres createuser --superuser root
sudo -u postgres createdb root
psql -c "ALTER USER vagrant WITH PASSWORD 'vagrant';"

echo '
host    all             all             0.0.0.0/0            md5' >> /etc/postgresql/9.5/main/pg_hba.conf
echo "
listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf
service postgresql restart


# Libs
install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo '
alias bu=bundle
alias be="bundle exec"
alias rk="bundle exec rake"
alias sp=bin/rspec
alias spe="bin/rspec -e"
' >> /home/vagrant/.bashrc

echo 'all set, rock on!'
