################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v10
#
# Recipe:: aix_server_install
#
# Cookbok: DB2 V10
#
# Made by: Daniel Abraao Silva Costa (dasc@br.ibm.com)
#

package_file = Chef::Config[:file_cache_path] + "/" + node['db2']['package']['file']
response_path = node['db2']['cache'] + "/aix_server.rsp.erb"
install_log_path = node['db2']['cache'] + "/silent_install.log"
db2_cache_path = node['db2']['install']['cache']
dynamic_url = "http://#{$BEST_SERVER}#{node['db2']['package']['url']}"


# Testing if the IM is already installed
if (!(File.directory?(node['db2']['main']['path'])))

  # Clean up the cache dir
  execute "Cleaning up the Cache Path" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "rm -Rf #{node['db2']['cache']}"
    action :run
  end
  
  # Create directory for config cache
  if (!(File.directory?(node['db2']['cache'])))
    directory node['db2']['cache'] do
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
 
  # Uncompressing the DB2 install package
  log "Uncompressing the package installer ..."  
  execute "Uncompressing the package installer" do
    user "root"
    cwd node['db2']['cache']
    command "gunzip < #{package_file} | tar xvf -"
    action :run
  end
  
  # Preparing the reponse file
  log "Preparing the responsive file ..."  
  template response_path do
    source "aix_server.rsp.erb"
    owner  'root'
    group  'system'
    mode   '0600'
    action :touch
  end
  
  log "Creating administrative groups ..." 
  node['db2']['groups']['array'].each do |group| 
    execute "Making group: #{group}" do
      user "root"
      cwd node['db2']['cache']
      command "mkgroup #{group}"
      not_if "grep #{group} /etc/group"
      action :run
    end
  end    
  
  log "Creating administrative users ..."
  node['db2']['users']['cmd'].each do |user| 
    execute "Adding user: #{user}" do
      user "root"
      cwd node['db2']['cache']
      command "useradd -g #{user}"
      not_if "grep #{user} /etc/passwd"
      action :run
    end
  end
    
  log "Creating home directories ..."
  directory node['db2']['directories']['array'][0] do
    owner "dasusr1"
    group "dasadm1"
    mode "0755"
    recursive true
    action :create
  end
  
  directory node['db2']['directories']['array'][1] do
    owner "db2inst1"
    group "db2iadm1"
    mode "0755"
    recursive true
    action :create
  end
  
  directory node['db2']['directories']['array'][2] do
    owner "db2fenc1"
    group "db2fadm1"
    mode "0755"
    recursive true
    action :create
  end
     
  # Install DB2 silently
  log "Installing DB2 V10 Silenty ..."  
  execute "Installing DB2 ESE silenty" do
    user "root"
    cwd db2_cache_path
    command "#{db2_cache_path}db2setup -l #{install_log_path} -r #{response_path}"
    action :run
  end
  
  # Remove Installers
  execute "Removing installers" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "rm -rf *"
    action :run
  end 
end
