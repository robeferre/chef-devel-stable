
package_file = Chef::Config[:file_cache_path] + "\\" + node['wee']['file']
response_path = node['wee']['cache'] + "\\wee_rhel_install.rsp"
install_log_path = node['wee']['cache'] + "\\silent_install.log"
dynamic_url = "http://#{$BEST_SERVER}#{node['wee']['url']}"


# Testing if the WEE is already installed
if (!(File.directory?(node['wee']['wl_install_dir'])))
  
  # Creating a directory to store WEE Liberty
  
  log "Creating the cache directory ..." 
  directory node['wee']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0755
      action :create
  end
  
  
  # Downloading the installation package
  
  log "Downloading the installation package ..."  
  remote_file node['wee']['cache'] do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end
  
  
  # Uncompressing Worklight zip file
  
  log "Unzip the WL package file" 
  if !File.directory? node['wee']['wl_cache']
   bash "unzip_wee" do
    code <<-EOL
    unzip package_file -d node['wee']['wl_cache']
    EOL
   end 
  end
  
  
  # Performing the silent install of WEE
  
  log "Creating the IMShared directory" 
  directory node['wee']['im_shared_dir'] do
      owner "root"
      group "root"
      mode 0755
      action :create
  end
  
  
  template response_path do
    source "wee_rhel_install.rsp.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  
  log "Running the Silent install of Workligt" 
  if !File.directory? node['wee']['wl_install_dir']
   bash "install_wee" do
    returns [0, 1]    
    code <<-EOL
    /opt/IBM/InstallationManager/eclipse/tools/imcl input response_path -log install_log_path -acceptLicense
    /opt/IBM/WebSphere/Liberty/bin/server start simpleServer
    EOL
   end 
  end
  
  # Remove Installers
  execute "Removing installers" do
   user "root"
   cwd Chef::Config[:file_cache_path]
   command "del /q *.* && for /d %x in (*.*) do @rd /s /q %x"
   action :run
  end 

end