# Cookbook Name:: open_call
# Recipe:: repo

git node['open_call']['repo_path'] do
  repository 'git://github.com/fdibartolo/opencall.git'
  action :checkout
end

bash 'copy .env file' do
  cwd node['open_call']['repo_path']
  code 'cp .env .env_backup'
  code 'cp .env_sample .env'
end

bash 'bundle gems and setup database' do
  cwd node['open_call']['repo_path']
  code 'bundle install && bundle exec rake db:setup'
end

directory 'create temp scripts dir' do
  path "#{node['open_call']['repo_path']}/tmp/scripts"
  recursive true
  action :create
end

template "#{node['open_call']['repo_path']}/tmp/scripts/create_elasticsearch_indices.rb" do
  source 'create_elasticsearch_indices.erb'
  variables :port => node['open_call']['elasticsearch_port'], :command => "#{node['open_call']['elasticsearch_path']}/elasticsearch/bin/elasticsearch"
end

bash 'create elasticsearch indices' do
  cwd node['open_call']['repo_path']
  code "rails runner 'tmp/scripts/create_elasticsearch_indices.rb'"
end
