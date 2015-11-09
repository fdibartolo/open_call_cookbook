#
# Cookbook Name:: open_call_cookbook
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git::default'

include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
rbenv_ruby "2.2.1" do
  global true
end
