# require 'pry'


package_file = node['mysql']['client']['singlepkg_name']
single_client_path = Chef::Config[:file_cache_path] + "/" + node['mysql']['client']['singlepkg_name']
  
remote_file single_client_path do
  source node['mysql']['client']['singlepkg_url']
  not_if { ::File.exists?(single_client_path) }
end
 
package package_file do
  action :install
  source single_client_path
  provider Chef::Provider::Package::Rpm
end