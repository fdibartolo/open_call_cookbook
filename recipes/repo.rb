# Cookbook Name:: open_call
# Recipe:: repo

git '/vagrant/repo' do
  repository 'git://github.com/nicopaez/opencall.git'
  action :checkout
end

bash 'copy .env file' do
  cwd '/vagrant/repo'
  code 'cp .env_sample .env'
end

bash 'bundle gems and setup database' do
  cwd '/vagrant/repo'
  code 'bundle install && bundle exec rake db:setup'
end

template '/vagrant/repo/create_elasticsearch_indices.rb' do
  source 'create_elasticsearch_indices.erb'
end

bash 'create elasticsearch indices' do
  cwd '/vagrant/repo'
  code 'foreman run rails runner create_elasticsearch_indices.rb'
end
