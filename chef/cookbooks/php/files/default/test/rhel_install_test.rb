require 'minitest/spec'

describe_recipe 'php::test' do
  
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it "dumps the correct files into place with correct owner and group" do
    file(node['php']['config_file']).must_have(:owner, "root").and(:group, "root")
  end

end