#
# Cookbook Name:: open_call_cookbook
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# git ######################

include_recipe 'git::default'

# ruby #####################

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '2.2.1' do
  global true
end

rbenv_gem 'bundler' do
  ruby_version '2.2.1'
  version '1.9.1'
end

rbenv_gem 'foreman' do
  ruby_version '2.2.1'
  version '0.78.0'
end

# java #####################

include_recipe 'java'

# node #####################

include_recipe 'nodejs'

# elasticsearch ############

elasticsearch_install 'elasticsearch' do
  type :tarball
  dir '/usr/local'
  version '1.4.5'
  owner 'vagrant'
  group 'vagrant'
  action :install
end

# ruby_block "add-elasticsearch-to-PATH" do
#   block do
#     file = Chef::Util::FileEdit.new('/home/vagrant/.profile')
#     file.insert_line_if_no_match(
#       "# Add elasticsearch to PATH",
#       "\n# Add elasticsearch to PATH\nexport PATH=\"/usr/local/elasticsearch/bin:$PATH\""
#     )
#     file.write_file
#   end
# end

# execute 'elasticsearch' do
#   environment 'PATH' => "/usr/local/elasticsearch/bin:#{ENV['PATH']}"
# end

include_recipe 'postgresql::server'
