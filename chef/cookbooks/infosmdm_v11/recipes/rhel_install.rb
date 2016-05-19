infosmdm_package_file1 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file1']
infosmdm_package_file2 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file2']
infosmdm_package_file3 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file3']
infosmdm_package_file4 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file4']
infosmdm_package_file5 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file5']
infosmdm_package_file6 = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['pkg_file6']
infomdmkit_package_file = Chef::Config[:file_cache_path] + "/" + node['infosmdm']['startup_kit']['pkg_file']

infosmdm_startupkit_rsp_path  = node['infosmdm']['cache'] + "/infomdm_v113_startup_kit.rsp"
startupkit_installation_log = node['infosmdm']['cache'] + "/startupkit_installation.log"

infosmdm_response_path  = node['infosmdm']['cache'] + "/install_single_servers_linux.res"
infosmdm_installation_log = node['infosmdm']['cache'] + "/infosmdm_installation.log"

im_tools_path = node['infosmdm']['im_tools_path']
infomdm_im_cache_path = node['infosmdm']['im_cache_path']
startupkit_im_cache_path  = node['infosmdm']['startup_kit']['im_cache_path']

dynamic_url1 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg1_url']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg2_url']}"
dynamic_url3 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg3_url']}"
dynamic_url4 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg4_url']}"
dynamic_url5 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg5_url']}"
dynamic_url6 = "http://#{$BEST_SERVER}#{node['infosmdm']['pkg6_url']}"
dynamic_url7 = "http://#{$BEST_SERVER}#{node['infosmdm']['startup_kit']['pkg_url']}"

db2_createdb_sql_path = node['infosmdm']['cache'] + "/create_db_db2.sql"
db2_createts_sql_path = node['infosmdm']['cache'] + "/create_ts_db2.sql"

full_name = "#{node['fqdn']}"
host_name = "#{node['hostname']}"
domain_name = "#{node['domain']}"

if (!(File.directory?(node['infosmdm']['base_install'])))
  
  # Creates the InfoSphere MDM v11 Cache Directory
  log "Creating the InfoSphere MDM cache dir ..." 
  directory node['infosmdm']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0777
      action :create
  end
  
  # Download the installer packages
  # log "Downloading MDM Installation Startup Kit ..."  
  # remote_file infomdmkit_package_file do
  #   source dynamic_url7
  #   not_if { ::File.exists?(infomdmkit_package_file) }
  # end

  log "Downloading InfoSphere MDM v11 file 1 of 6..."  
  remote_file infosmdm_package_file1 do
    source dynamic_url1
    not_if { ::File.exists?(infosmdm_package_file1) }
  end

  log "Downloading InfoSphere MDM v11 file 2 of 6..."  
  remote_file infosmdm_package_file2 do
    source dynamic_url2
    not_if { ::File.exists?(infosmdm_package_file2) }
  end

  log "Downloading InfoSphere MDM v11 file 3 of 6..."  
  remote_file infosmdm_package_file3 do
    source dynamic_url3
    not_if { ::File.exists?(infosmdm_package_file3) }
  end

  log "Downloading InfoSphere MDM v11 file 4 of 6..."  
  remote_file infosmdm_package_file4 do
    source dynamic_url4
    not_if { ::File.exists?(infosmdm_package_file4) }
  end

  log "Downloading InfoSphere MDM v11 file 5 of 6..."  
  remote_file infosmdm_package_file5 do
    source dynamic_url5
    not_if { ::File.exists?(infosmdm_package_file5) }
  end

  log "Downloading InfoSphere MDM v11 file 6 of 6..."  
  remote_file infosmdm_package_file6 do
    source dynamic_url6
    not_if { ::File.exists?(infosmdm_package_file6) }
  end
  
  # Change binaries permissions
  # execute "Changing permissions from #{infomdmkit_package_file}" do
  #   user "root"
  #   cwd Chef::Config[:file_cache_path]
  #   command "chmod 0777 #{infomdmkit_package_file}"
  #   action :run
  # end

  execute "Changing permissions from #{infosmdm_package_file1}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file1}"
    action :run
  end

  execute "Changing permissions from #{infosmdm_package_file2}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file2}"
    action :run
  end

  execute "Changing permissions from #{infosmdm_package_file3}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file3}"
    action :run
  end

  execute "Changing permissions from #{infosmdm_package_file4}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file4}"
    action :run
  end

  execute "Changing permissions from #{infosmdm_package_file5}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file5}"
    action :run
  end

  execute "Changing permissions from #{infosmdm_package_file6}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infosmdm_package_file6}"
    action :run
  end
 
  # # Prepares the response files (intaller.properties)
  # template infosmdm_startupkit_rsp_path do
  #   source "infomdm_v113_startup_kit.rsp.erb"
  #   owner  'dstadmin'
  #   group  'dstadmin'
  #   mode   '0600'
  #   action :touch
  # end
  
  # Uncompressing the StartupKit package files
  # execute "Uncompressing the MDM Installation Startup Kit ..." do
  #   user "dstadmin"
  #   group "dstadmin"
  #   cwd Chef::Config[:file_cache_path]
  #   command "unzip -o #{infomdmkit_package_file} -d #{startupkit_im_cache_path}"
  #   action :run
  #   not_if "ls -lhar #{startupkit_im_cache_path}"
  # end
  
  # Execute the Installation
  # execute "Installing MDM Installation Startup Kit..." do
  #   user "root"
  #   group "root"
  #   returns [0]
  #   cwd Chef::Config[:file_cache_path]
  #   command "#{im_tools_path}/imcl input #{infosmdm_startupkit_rsp_path} -log #{startupkit_installation_log} -acceptLicense"
  #   action :run
  # end


  # Uncompressing MDM the package files
  execute "Uncompressing the MDM package 1 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file1} -d #{infomdm_im_cache_path}"
    action :run
  end

  execute "Uncompressing the MDM package 2 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file2} -d #{infomdm_im_cache_path}"
    action :run
  end

  execute "Uncompressing the MDM package 3 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file3} -d #{infomdm_im_cache_path}"
    action :run
  end

  execute "Uncompressing the MDM package 4 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file4} -d #{infomdm_im_cache_path}"
    action :run
  end

  execute "Uncompressing the MDM package 5 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file5} -d #{infomdm_im_cache_path}"
    action :run
  end

  execute "Uncompressing the MDM package 6 of 6 ..." do
    user "dstadmin"
    group "dstadmin"
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{infosmdm_package_file6} -d #{infomdm_im_cache_path}"
    action :run
  end


  ###########
  # Create and Setup a WAS Profile and Node
  ###########

  # log "Setting up a WAS Profile and Node ..." 
  include_recipe "infosmdm_v11::rhel_was_profile_creation"




  ###########
  # Create and Configure the MDM database
  ###########

  # log "Creating and Setting up the MDM database ..." 

  # # Prepare the sql files
  template db2_createdb_sql_path do
    source "create_db_db2.sql.erb"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end

  template db2_createts_sql_path do
    source "create_ts_db2.sql.erb"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end


  # # Call the recipe (run the sql commands)
  include_recipe "infosmdm_v11::rhel_db2_setup"



  ###########
  # MDM Installation - preparing esponse files (intaller.properties)
  ###########

  template infosmdm_response_path do
    source "install_single_servers_linux.res.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   '0600'
    action :touch
    variables({
      :fullname => "#{full_name}",
      :hostname => "#{host_name}"
    })
  end

  # Execute the Installation
  execute "Installing InfoSphere MDM v11.4 ..." do
    user "root"
    group "root"
    returns [0]
    timeout 10800
    cwd Chef::Config[:file_cache_path]
    command "#{im_tools_path}/imcl input #{infosmdm_response_path} -log #{infosmdm_installation_log} -acceptLicense -showProgress"
    action :run
  end
  
  # Remove Installers and garbage
  # execute "Removing temporary files ..." do
  #  user "root"
  #  cwd Chef::Config[:file_cache_path]
  #  command "rm -rf *"
  #  action :run
  # end
  
  log "Installation Complete"  
  
else
  log "InfoSphere MDM v11 is already installed on this machine." do
  level :info
  end
end
