# Cookbook Name:: open_call
# Recipe:: ruby

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node['open_call']['ruby_version'] do
  global true
end

rbenv_gem 'bundler' do
  ruby_version node['open_call']['ruby_version']
  version '1.9.1'
end

rbenv_gem 'foreman' do
  ruby_version node['open_call']['ruby_version']
  version '0.78.0'
end
