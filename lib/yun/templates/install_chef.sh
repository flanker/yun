#!/bin/bash

sudo apt-get update
sudo apt-get install -y --force-yes ruby ruby-dev libopenssl-ruby rdoc ri irb build-essential wget ssl-cert git-core

if test ! -x /usr/bin/gem; then
  cd /tmp
  wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
  tar zxf rubygems-1.8.10.tgz
  cd rubygems-1.8.10
  sudo ruby setup.rb --no-format-executable
fi

sudo gem install chef --no-ri --no-rdoc
