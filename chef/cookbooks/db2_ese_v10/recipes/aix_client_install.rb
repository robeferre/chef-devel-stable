################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v10
#
# Recipe:: aix_client_install
#
# Cookbok: DB2 V10 Client
#
# Made by: Daniel Abraao Silva Costa (dasc@br.ibm.com)
#

package_file = Chef::Config[:file_cache_path] + "/" + node['db2']['client']['package']['file']
response_path = node['db2']['client']['response']['file']
response_path = node['db2']['client']['cache'] + "/aix_client.rsp"
install_log_path = node['db2']['client']['cache'] + "/silent_install.log"
db2_cache_path = node['db2']['client']['install']['cache']
dynamic_url = "http://#{$BEST_SERVER}#{node['db2']['client']['package']['url']}"


  # Clean up the cache dir
  execute "Cleaning up the Cache Path" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "rm -Rf #{node['db2']['client']['cache']}"
    action :run
  end
  
  # Create directory for config cache
  if (!(File.directory?(node['db2']['client']['cache'])))
    directory node['db2']['client']['cache'] do
       owner "root"
       group "system"
       mode "0755"
       recursive true
       action :create
    end   
  end
  
  # Downloading the installation package
  log "Downloading the installation package ..."  
  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end
 
  # Uncompressing the DB2 client install package
  log "Uncompressing the package installer ..."  
  execute "Uncompressing the package installer" do
    user "root"
    cwd node['db2']['client']['cache']
    command "tar -xvf #{package_file}"
    action :run
  end
  
  # Preparing the reponse file
  log "Preparing the responsive file ..."  
  template response_path do
    source "aix_client.rsp.erb"
    owner  'root'
    group  'system'
    mode   '0600'
    action :touch
  end
  
  log "Stopping current db2 instances ..."  
  if File.directory? node['db2']['main']['path']
  bash "Stopping db2inst1 instance" do
    returns [0, 1]    
    code <<-EOL
    /home/db2inst1/sqllib/adm/db2stop
    EOL
   end 
  end
  
  # Install DB2 client silently
  log "Installing DB2 V10 client Silenty ..."  
  execute "Installing DB2 ESE silenty" do
    user "root"
    cwd db2_cache_path
    command "#{db2_cache_path}db2setup -l #{install_log_path} -r #{response_path}"
    action :run
  end
  
  log "Starting current db2 instances ..."  
  if File.directory? node['db2']['main']['path']
  bash "Starting db2inst1 instance" do
    returns [0, 1]    
    code <<-EOL
    /home/db2inst1/sqllib/adm/db2start
    EOL
   end 
  end
    
  # Remove Installers
  execute "Removing installers" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "rm -rf *"
    action :run
  end
