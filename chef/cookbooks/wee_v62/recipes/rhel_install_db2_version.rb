package_file = Chef::Config[:file_cache_path] + "/" + node['wee62']['file']
response_path = node['wee62']['cache'] + "/install-liberty-db2.xml"
install_log_path = node['wee62']['cache'] + "/silent_install.log"
wl_cache_path = node['wee62']['wl_cache']
im_shared_dir = node['wee62']['im_shared_dir']
dynamic_url = "http://#{$BEST_SERVER}#{node['wee62']['url']}"

# Testing if the WEE is already installed
if (!(File.directory?(node['wee62']['wl_install_dir'])))
  
  # Creating a directory to store WEE v6.2
  log "Creating the cache directory ..." 
  directory node['wee62']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0755
      action :create
  end
  
  
  # Downloading the installation package
  log "Downloading the installation package ..."  

  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end

  log "Creating the IMShared directory ..." 
  if !File.directory? node['wee62']['im_shared_dir']
    directory node['wee62']['im_shared_dir'] do
        owner "root"
        group "root"
        mode 0755
        action :create
    end
  end
  
  # Uncompressing Worklight zip file
  bash "Unzip the WEE v6.2 package file ..." do
    code <<-EOL
    unzip -o #{package_file} -d #{im_shared_dir}
    EOL
  end
    
  # Performing the silent install of WEE
  template response_path do
    source "install-liberty-db2.xml.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end

  # Execute sql to create APPCNTR database
  bash "Creating APPCNTR database ... " do
    user "db2inst1"
    group "dasadm1"
    code <<-EOL 
      /home/db2inst1/sqllib/bin/db2 CREATE DATABASE APPCNTR COLLATE USING SYSTEM PAGESIZE 32768;
      /home/db2inst1/sqllib/bin/db2 TERMINATE;
    EOL
  end
    
   bash "Running the WEE v6.2 silent install..." do
    returns [0]    
    code <<-EOL
    /opt/IBM/InstallationManager/eclipse/tools/imcl input #{response_path} -log #{install_log_path} -acceptLicense
    /opt/IBM/WebSphere/Liberty/bin/server start simpleServer
    EOL
  end
  
  # Remove Installers
  execute "Removing installers" do
   user "root"
   cwd Chef::Config[:file_cache_path]
   command "rm -rf *"
   action :run
  end 
  
else
  log "IBM WorkLight Enterprise Edition v6.2 is already installed!" do
  level :info
  end
end
