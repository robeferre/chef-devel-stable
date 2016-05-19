
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
  execute "Download archive file" do
    cwd Chef::Config[:file_cache_path]
    command "scp -C -i /home/chefclt/.ssh/id_rsa -o StrictHostKeyChecking=no chefclt@#{$BEST_SERVER}:#{node['wee']['url']} ."
    action :run
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
   bash "Unzip the WL package file ..." do
    code <<-EOL
    unzip -o #{package_file} -d #{im_shared_dir}
    EOL
  end
  
  # Performing the silent install of WEE62
  template response_path do
    source "wee_install.rsp.erb"
    owner "root"
    group "system"
    mode   '0600'
    action :touch
  end
  
  
   bash "Running the Silent install of Workligt ..." do
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
