yun 云
======

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
Basically it should contains:

    :default:
      :aws_access_key_id:
      :aws_secret_access_key:
      :region: us-west-1
      :key_name:
      :chef_repo: /PATH/TO/YOUR/CHEF_REPO

### create EC2 node

    yun node create NODE_NAME

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
* @冯智超 at Sina Weibo
