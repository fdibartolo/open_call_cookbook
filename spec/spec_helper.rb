require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

######################################################################################################
# As is, inline, until next version of rbenv-cookbook is released, which whould include these matchers
# https://github.com/RiotGamesCookbooks/rbenv-cookbook/pull/92
# 
def install_rbenv_ruby(ruby_version)
  ChefSpec::Matchers::ResourceMatcher.new(:rbenv_ruby, :install, ruby_version)
end

def install_rbenv_gem(package_name)
  ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :install, package_name)
end
