# Cookbook Name:: open_call
# Recipe:: elasticsearch

# elasticsearch_user 'vagrant'

# elasticsearch_install 'elasticsearch' do
#   type 'tarball'
#   dir node['open_call']['elasticsearch_path']
#   version node['open_call']['elasticsearch_version']
#   # owner 'vagrant'
#   # group 'vagrant'
#   action :install
# end

# directory '/etc/profile.d' do
#   mode 00755
# end

# file '/etc/profile.d/elasticsearch.sh' do
#   content "export PATH=#{node['open_call']['elasticsearch_path']}/elasticsearch/bin:$PATH"
#   mode 00755
# end

bash 'get elasticseach tar' do
  code "wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{node['open_call']['elasticsearch_version']}.tar.gz"
end

bash 'extract tar' do
  code "sudo tar -xzf elasticsearch-#{node['open_call']['elasticsearch_version']}.tar.gz -C #{node['open_call']['elasticsearch_path']}"
end

bash 'remove version from dir' do
  code "sudo mv #{node['open_call']['elasticsearch_path']}/elasticsearch-#{node['open_call']['elasticsearch_version']} #{node['open_call']['elasticsearch_path']}/elasticsearch"
end

file "elasticsearch-#{node['open_call']['elasticsearch_version']}.tar.gz" do
  action :delete
end

bash 'bin ownership' do
  code "sudo chown -R vagrant:vagrant #{node['open_call']['elasticsearch_path']}/elasticsearch/"
end
