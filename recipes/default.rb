# Cookbook Name:: open_call
# Recipe:: default

include_recipe 'git'
include_recipe 'open_call::ruby'
include_recipe 'java'
include_recipe 'nodejs'
include_recipe 'open_call::elasticsearch'
include_recipe 'postgresql::server'
