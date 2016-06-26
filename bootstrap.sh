#!/bin/bash

set -e

# Create swapfile of 1GB with block size 1MB
dd if=/dev/zero of=/swapfile bs=1024 count=1048576

# Set up the swap file
mkswap /swapfile

# Enable swap file immediately
swapon /swapfile

# Enable swap file on every boot
echo '/swapfile          swap            swap    defaults        0 0' >> /etc/fstab

apt-get update

apt-get install -y git-core
apt-get install -y build-essential
# apt-get install -y openjdk-7-jdk

export DEBIAN_FRONTEND=noninteractive

apt-get install -y mysql-server
# apt-get install -y mongodb
# apt-get install -y redis-server
# apt-get install -y memcached

apt-get install -y npm
ln -s `which nodejs` /usr/bin/node

apt-get install -y libssl-dev libreadline-dev zlib1g-dev
apt-get install -y libmysqlclient-dev
apt-get install -y libmagickwand-dev imagemagick

exec sudo -i -u vagrant /bin/bash - <<'AS_VAGRANT'

mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'MAUKA_DEV'@'localhost' WITH GRANT OPTION;"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'MAUKA_DEV'@'%' WITH GRANT OPTION;"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

RV=2.3.0

rbenv install $RV
rbenv global $RV
rbenv rehash

gem install bundler

AS_VAGRANT
