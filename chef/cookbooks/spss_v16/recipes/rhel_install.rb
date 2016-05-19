srv_package_file = Chef::Config[:file_cache_path] + "/" + node['spss']['srv_file']
batch_package_file = Chef::Config[:file_cache_path] + "/" + node['spss']['batch_file']
srv_response_path = node['spss']['cache'] + "/spss_srv_installer.properties"
batch_response_path = node['spss']['cache'] + "/spss_batch_installer.properties"
srv_install_log = node['spss']['cache'] + "/spss_srv_installation.log"
batch_install_log = node['spss']['cache'] + "/spss_batch_installation.log"
dynamic_url1 = "http://#{$BEST_SERVER}#{node['spss']['url_srv']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['spss']['url_batch']}"


if (!(File.directory?(node['spss']['base_install'])))
  
  # Creates the SPS Cache Directory
  log "Creating the SPSS Cache dir ..." 
  directory node['spss']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0755
      action :create
  end
  
  # Download the installation packages
  log "Downloading SPSS Modeler Server installer ..."  
  remote_file srv_package_file do
    source dynamic_url1
    not_if { ::File.exists?(srv_package_file) }
  end
  
  log "Downloading SPSS Modeler Batch installer ..."  
  remote_file batch_package_file do
    source dynamic_url2
    not_if { ::File.exists?(batch_package_file) }
  end
    
  # Prepares the response files (intaller.properties)
  template srv_response_path do
    source "spss_srv_properties.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  template batch_response_path do
    source "spss_batch_properties.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  # Change binaries permissions
  execute "Changing permissions from #{srv_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{srv_package_file}"
    action :run
  end
  
   execute "Changing permissions from #{batch_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{batch_package_file}"
    action :run
  end
  
  # Execute the Installations
  execute "Installing SPSS Modeler Server silently..." do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "./#{node['spss']['srv_file'] } -i silent -f #{srv_response_path} -l #{srv_install_log}"
    action :run
  end
  
  execute "Installing SPSS Modeler Batch silently..." do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "./#{node['spss']['batch_file'] } -i silent -f #{batch_response_path} -l #{batch_install_log}"
    action :run
  end
  
  # Starts the SPSS Server
  execute "Starting the SPSS Modeler Server..." do
    user "root"
    command "sh #{node['spss']['base_install']}/modelersrv.sh start"
    action :run
  end
 
 # Creates a startup process
  execute "Creating a startup script ..." do
    user "root"
    command "echo 'sh #{node['spss']['base_install']}/modelersrv.sh start' >> /etc/rc.d/rc.local"
    not_if "grep modelersrv.sh /etc/rc.d/rc.local"
    action :run
  end
  
  # Remove Installers and garbage
  execute "Removing temporary files ..." do
   user "root"
   cwd Chef::Config[:file_cache_path]
   command "rm -rf *"
   action :run
  end
  
  log "Installation Complete"  
  
else
  log "SPSS v16 is already installed on this machine." do
  level :info
  end
end
