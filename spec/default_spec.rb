require 'spec_helper'

describe 'open_call::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  before do
    %w(
      git 
      open_call::ruby 
      java 
      nodejs 
      open_call::elasticsearch 
      postgresql::server
    ).each do |recipe_name|
      allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe_name)
    end
  end

  %w(
    git 
    open_call::ruby 
    java 
    nodejs 
    open_call::elasticsearch 
    postgresql::server
  ).each do |recipe_name|
    it "includes the #{recipe_name} recipe" do
      expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with(recipe_name)
      chef_run
    end
  end
end