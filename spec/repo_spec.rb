require 'spec_helper'

describe 'open_call::repo' do
  let(:chef_run) do 
    ChefSpec::SoloRunner.new do |node|
      node.normal['open_call']['elasticsearch_port'] = 9292
      node.normal['open_call']['elasticsearch_path'] = '/some/path'
    end.converge(described_recipe)
  end

  it 'clones the git repo' do
    expect(chef_run).to checkout_git('/vagrant/repo')
  end

  it 'copies the .env file' do
    expect(chef_run).to run_bash('copy .env file').
      with(cwd: '/vagrant/repo', code: 'cp .env_sample .env')
  end

  it 'bundles gems and setups database' do
    expect(chef_run).to run_bash('bundle gems and setup database').
      with(cwd: '/vagrant/repo', code: 'bundle install && bundle exec rake db:setup')
  end

  describe 'creates file' do
    it 'from template to create elasticsearch indices' do
      expect(chef_run).to create_template('/vagrant/repo/tmp/scripts/create_elasticsearch_indices.rb').
        with(source: 'create_elasticsearch_indices.erb')
    end

    it 'with given elasticsearch port and ES path attributes' do
      expect(chef_run).to render_file('/vagrant/repo/tmp/scripts/create_elasticsearch_indices.rb').
        with_content { |content|
          expect(content).to include("port: 9292, command: '/some/path/elasticsearch/bin/elasticsearch'") 
        }
    end
  end

  it 'creates the elasticsearch indices' do
    expect(chef_run).to run_bash('create elasticsearch indices').
      with(cwd: '/vagrant/repo', code: "rails runner 'tmp/scripts/create_elasticsearch_indices.rb'")
  end
end
