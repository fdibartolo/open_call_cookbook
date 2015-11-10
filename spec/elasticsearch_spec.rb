require 'spec_helper'

describe 'open_call::elasticsearch' do
  let(:chef_run) do 
    ChefSpec::SoloRunner.new do |node|
      node.set['open_call']['elasticsearch_version'] = '9.8.7'
      node.set['open_call']['elasticsearch_path'] = '/some/path'
    end.converge(described_recipe)
  end

  it 'installs given elasticsearch version' do
    expect(chef_run).to install_elasticsearch('elasticsearch').with(version: '9.8.7')
  end

  it 'creates directory with mode 755' do
    expect(chef_run).to create_directory('/etc/profile.d').with(mode: 00755)
  end

  describe 'creates file' do
    it 'with given path in content' do
      expect(chef_run).to create_file('/etc/profile.d/elasticsearch.sh').with(mode: 00755)
    end

    it 'with mode 755' do
      expect(chef_run).to create_file('/etc/profile.d/elasticsearch.sh').
        with_content(start_with('export PATH=/some/path'))
    end
  end
end
