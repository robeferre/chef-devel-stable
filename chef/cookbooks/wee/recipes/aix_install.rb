
package_file = Chef::Config[:file_cache_path] + "/" + node['wee']['file']
response_path = node['wee']['cache'] + "/wee_install.rsp"
install_log_path = node['wee']['cache'] + "/silent_install.log"
wl_cache_path = node['wee']['wl_cache']
im_shared_dir = node['wee']['im_shared_dir']
dynamic_url = "http://#{$BEST_SERVER}#{node['wee']['url']}"


# Testing if the WEE is already installed
if (!(File.directory?(node['wee']['wl_install_dir'])))
  
  # Creating a directory to store WEE Liberty  
  log "Creating the cache directory ..." 
  directory node['wee']['cache'] do
      owner "root"
      group "system"
      mode 0755
      action :create
  end
  
  
  # Downloading the installation package
  
  log "Downloading the installation package ..."  
  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end
  
  log "Creating the IMShared directory" 
  if !File.directory? node['wee']['im_shared_dir']
    directory node['wee']['im_shared_dir'] do
        owner "root"
        group "system"
        mode 0755
        action :create
    end
  end
  
  # Uncompressing Worklight zip file
  
  log "Unzip the WL package file" 
   bash "unzip_wee" do
    code <<-EOL
    unzip -o #{package_file} -d #{im_shared_dir}
    EOL
  end
  
  # Performing the silent install of WEE

  template response_path do
    source "wee_install.rsp.erb"
      owner "root"
      group "system"
    mode   '0600'
    action :touch
  end
  
  
  log "Running the Silent install of Workligt" 
   bash "install_wee" do
    returns [0, 1]    
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
  log "DST CHEF script for WorkLight Enterprise Edition v1.0 is already installed!" do
  level :info
  end
end
