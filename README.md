yun 云
======
[![Build Status](https://secure.travis-ci.org/flanker/yun.png?branch=master)](http://travis-ci.org/flanker/yun)

About
-----

`yun` is a command line tool for manage Amazon EC2 environment.

It's still working in process. Now it supports `create`, `destroy`,
`list`, `ssh`, `chef provision` commands.

Ruby Gem
--------

Install `yun` by

    (sudo) gem install yun

You can find `yun` in rubygems.org

    https://rubygems.org/gems/yun

How to use
----------

### config file
After installing `yun`, you need to create a config file `~/.yun`.

Here is an example configuration:

    #######################################################
    # Yun Credentials File
    #
    :default:
      :aws_access_key_id: YOUR_AWS_ACCESS_KEY_ID
      :aws_secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY
      :region: us-west-1
      :key_name: YOUR_KEY_PAIR_NAME
      :chef_repo: /PATH/TO/YOUR/CHEF_REPO (optional)
      :os:
        :ubuntu:
          :image: ami-cba1fe8e
          :user: ubuntu
        :amazon:
          :image: ami-1bd68a5e
          :user: ec2-user
        :windows:
          :image: ami-ed3768a8
          :user:
        :centos:
          :image: ami-dd2f7298
          :user: root

### create EC2 node

    yun node create NODE_NAME --os OS_NAME --instance_type INSTANCE_TYPE

OS_NAME could be os listed in your `~/.yun` configuration file (`ubuntu`,
`amazon`, `centos`, etc).

INSTANCE_TYPE could be `micro`, `small`, etc

### list all EC2 node

    yun node list

### destroy EC2 node

    yun node destroy NODE_NAME

### ssh to EC2 node

    yun ssh NODE_NAME

### provision EC2 node using chef

    yun chef NODE_NAME ROLE_NAME

Other
-----

Feel free to contact me if you have any problem:

* flankerfc at Gmail
* [@fengzhichao](https://twitter.com/#!/fengzhichao)
* [@冯智超](http://www.weibo.com/flankerfc)
