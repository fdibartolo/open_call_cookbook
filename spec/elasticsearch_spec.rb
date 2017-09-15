require 'spec_helper'

describe 'open_call::elasticsearch' do
  let(:chef_run) do 
    ChefSpec::SoloRunner.new do |node|
      node.normal['open_call']['elasticsearch_version'] = '9.8.7'
      node.normal['open_call']['elasticsearch_path'] = '/some/path'
    end.converge(described_recipe)
  end

  it 'gets tarball' do
    expect(chef_run).to run_bash('get elasticseach tar').
      with(code: 'wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-9.8.7.tar.gz')
  end

  it 'extracts tarball' do
    expect(chef_run).to run_bash('extract tar').
      with(code: 'sudo tar -xzf elasticsearch-9.8.7.tar.gz -C /some/path')
  end

  it 'move directory' do
    expect(chef_run).to run_bash('remove version from dir').
      with(code: 'sudo mv /some/path/elasticsearch-9.8.7 /some/path/elasticsearch')
  end

  it 'deletes tarball' do
    expect(chef_run).to delete_file('elasticsearch-9.8.7.tar.gz')
  end

  it 'chown dir' do
    expect(chef_run).to run_bash('bin ownership').
      with(code: 'sudo chown -R vagrant:vagrant /some/path/elasticsearch/')
  end
end
