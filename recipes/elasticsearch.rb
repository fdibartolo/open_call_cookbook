# Cookbook Name:: open_call
# Recipe:: elasticsearch

elasticsearch_install 'elasticsearch' do
  type :tarball
  dir node['open_call']['elasticsearch_path']
  version node['open_call']['elasticsearch_version']
  owner 'vagrant'
  group 'vagrant'
  action :install
end

directory '/etc/profile.d' do
  mode 00755
end

file '/etc/profile.d/elasticsearch.sh' do
  content "export PATH=#{node['open_call']['elasticsearch_path']}/elasticsearch/bin:$PATH"
  mode 00755
end
