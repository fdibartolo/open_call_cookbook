# Cookbook Name:: open_call
# Recipe:: elasticsearch

elasticsearch_install 'elasticsearch' do
  type :tarball
  dir '/usr/local'
  version '1.4.5'
  owner 'vagrant'
  group 'vagrant'
  action :install
end

directory '/etc/profile.d' do
  mode 00755
end

file '/etc/profile.d/elasticsearch.sh' do
  content "export PATH=/usr/local/elasticsearch/bin:$PATH"
  mode 00755
end