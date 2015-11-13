require 'spec_helper'

describe 'open_call::repo' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

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

  it 'creates file with ruby code to create elasticsearch indices' do
    expect(chef_run).to create_template('/vagrant/repo/create_elasticsearch_indices.rb').
      with(source: 'create_elasticsearch_indices.erb')
  end

  it 'creates the elasticsearch indices' do
    expect(chef_run).to run_bash('create elasticsearch indices').
      with(cwd: '/vagrant/repo', code: 'foreman run rails runner create_elasticsearch_indices.rb')
  end
end
