################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v10
#
# Recipe:: rhel_server_install
#
# Cookbok: DB2 V10
#
# Made by: Daniel Abraao Silva Costa (dasc@br.ibm.com)
#

package_file = Chef::Config[:file_cache_path] + "/" + node['db2']['package']['file']
response_path = node['db2']['cache'] + "/rhel_server.rsp"
license_path = node['db2']['adm']['path'] + "/db2ese_c.lic"
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
       group "root"
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
    command "tar xvf #{package_file}"
    action :run
  end
  
  # Installing the pam library
  execute "Installing the pam-devel library" do
    user "root"
      cwd node['db2']['cache']
    command "yum -y install pam-devel"
    action :run
  end
  
  # Installing the pam library
  execute "Installing the pam.i686 library" do
    user "root"
    cwd node['db2']['cache']
    command "yum -y install pam.i686"
    action :run
  end
   
  log "Creating administrative groups ..." 
  node['db2']['groups']['array'].each do |group| 
    execute "Making group: #{group}" do
      user "root"
      cwd node['db2']['cache']
      command "groupadd #{group}"
      not_if "grep #{group} /etc/group"
      action :run
    end
  end    
  
  log "Creating administrative users ..."
  node['db2']['users']['cmd'].each do |user,pass| 
    execute "Adding user: #{user}" do
      user "root"
      cwd node['db2']['cache']
      command "useradd -g #{user} -p #{pass}"
      not_if "grep #{user} /etc/passwd"
      action :run
    end
  end
  
  # Preparing the reponse file
  log "Preparing the responsive file ..."  
  template response_path do
    source "rhel_server.rsp.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
     
  # Install DB2 silently
  log "Installing DB2 V10 Silenty ..."  
  execute "Installing DB2 ESE silenty" do
    user "root"
    cwd db2_cache_path
    command "#{db2_cache_path}db2setup -l #{install_log_path} -r #{response_path}"
    action :run
  end
  
    # Preparing the license file
  log "Preparing the license file file ..."  
  template license_path do
    source "db2ese_c.lic.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  # Activating the DB2 ESE license
  execute "Activating the DB2 v10.1 license ..." do
    user "root"
    cwd node['db2']['adm']['path']
    command "./db2licm -a db2ese_c.lic"
    action :run
  end
  
  execute "Listing DB2 v10.1 license ..." do
    user "root"
    cwd node['db2']['adm']['path']
    command "./db2licm -l"
    action :run
  end
  
  execute "Removing temp files ..." do
    user "root"
    cwd node['db2']['adm']['path']
    command "rm -f db2ese_c.lic"
    action :run
  end
  
  
  # Activating the fault monitor
  execute "Activating the DB2 fault monitor ..." do
    user "db2inst1"
    cwd node['db2']['bin']['path']
    command "./db2iauto -on db2inst1;./db2fm -i db2inst1 -U;./db2fm -i db2inst1 -f on"
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