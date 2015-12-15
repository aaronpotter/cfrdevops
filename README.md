# CFR Devops technical challenge

## Overview

A repo for showcasing building a vagrant VM using chef-solo per challenge specification

## Install

### Requirements

- [Vagrant](http://vagrantup.com/)

### Optional for debugging
- [Chef](http://chef.io)

### Steps

1. run `vagrant up`
2. run `vagrant ssh`
3. DONE!

## Debugging

1. Edit the Vagrantfile, uncommenting the debug level
2. Edit the solo.rb indication the path of the cookbook as it is on your computer
3. run `chef-solo --config solo.rb --override-runlist 'recipe[cfrdevops]'`
