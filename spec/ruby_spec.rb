require 'spec_helper'

describe 'open_call::ruby' do
  let(:chef_run) do 
    ChefSpec::SoloRunner.new do |node|
      node.set['open_call']['ruby_version'] = '9.8.7'
      node.set['open_call']['ruby_gems'] = [{ 'some_gem' => '1.2.3' }]
    end.converge(described_recipe)
  end

  before do
    %w(
      rbenv::default 
      rbenv::ruby_build
    ).each do |recipe_name|
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe_name)
    end
  end

  describe 'installs ruby' do
    it 'with given version' do
      expect(chef_run).to install_rbenv_ruby('9.8.7')
    end
    it 'as global' do
      expect(chef_run).to install_rbenv_ruby('9.8.7').with(global: true)
    end
  end

  it 'installs given ruby gems' do
    expect(chef_run).to install_rbenv_gem('some_gem').with(version: '1.2.3')
  end
end