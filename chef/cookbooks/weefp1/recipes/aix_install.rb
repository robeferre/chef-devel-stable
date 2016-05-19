
package_file = Chef::Config[:file_cache_path] + "/" + node['weefp1']['file']
response_path = node['weefp1']['cache'] + "/weefp1_install.rsp"
install_log_path = node['weefp1']['cache'] + "/silent_install.log"
wl_cache_path = node['weefp1']['wl_cache']
im_shared_dir = node['weefp1']['im_shared_dir']
dynamic_url = "http://#{$BEST_SERVER}#{node['weefp1']['url']}"

  
  # Creating a directory to store WEE Liberty  
  log "Creating the cache directory ..." 
  directory node['weefp1']['cache'] do
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
  if !File.directory? node['weefp1']['im_shared_dir']
    directory node['weefp1']['im_shared_dir'] do
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
    source "weefp1_install.rsp.erb"
      owner "root"
      group "system"
    mode   '0600'
    action :touch
  end
  
  
  log "Running the Silent install of Workligt" 
   bash "install_wee" do
    returns [0, 1]    
    code <<-EOL
    /opt/IBM/WebSphere/Liberty/bin/server stop simpleServer
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

