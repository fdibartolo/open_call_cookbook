# Cookbook Name:: open_call
# Recipe:: ruby

package 'Install libffi-dev' do
  package_name 'libffi-dev'
end

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node['open_call']['ruby_version'] do
  global true
end

node['open_call']['ruby_gems'].each do |gem|
  rbenv_gem gem.keys.first do
    ruby_version node['open_call']['ruby_version']
    version gem.values.first
  end
end
