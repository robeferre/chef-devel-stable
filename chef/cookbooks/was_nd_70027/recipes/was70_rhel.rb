###################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

was_installer_url         = "http://#{$BEST_SERVER}#{node['installer']['url']}"
was_update_installer_url  = "http://#{$BEST_SERVER}#{node['update_installer']['url']}"
was_fixpack27_url         = "http://#{$BEST_SERVER}#{node['fixpack27']['url']}"

CONFIG_CACHE              = node['cache']['path']
WAS_BASE_INSTALLATION     = node['installation']['path']
WAS_BASE_TEMPLATE         = node['template']['path']
RSP_INSTALL_PATH          = "#{CONFIG_CACHE}/was70_response_file.rsp"
RSP_UPDATE_INSTALL_PATH   = "#{CONFIG_CACHE}/was70_response_file_update_install.rsp"
RSP_FIXPACK27_PATH        = "#{CONFIG_CACHE}/was70_response_file_fixpack27.rsp"
INSTALLER_FILE            = node['installer']['file_name'] 
UPDATE_INSTALLER_FILE     = node['update_installer']['file_name'] 
FIXPACK27_FILE            = node['fixpack27']['file_name']
WAS_PROFILE_NAME          = node['profile_name']


Chef::Log.info("--- Installing Web Sphere 7.0.0.27 ----")

if (!(File.directory?("#{CONFIG_CACHE}")))
  directory "#{CONFIG_CACHE}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

remote_file "#{CONFIG_CACHE}/#{INSTALLER_FILE}" do
  source was_installer_url
  action :create_if_missing
end 

remote_file "#{CONFIG_CACHE}/#{UPDATE_INSTALLER_FILE}" do
   source was_update_installer_url
   action :create_if_missing
end

remote_file "#{CONFIG_CACHE}/#{FIXPACK27_FILE}" do
   source was_fixpack27_url 
   action :create_if_missing
end

execute "Untar #{INSTALLER_FILE}" do
    user "root"
    cwd CONFIG_CACHE
    command "tar -xf #{INSTALLER_FILE} -C #{CONFIG_CACHE}"
    action :run
end

execute "Untar #{UPDATE_INSTALLER_FILE}" do
  user "root"
  cwd CONFIG_CACHE
  command "tar -xf #{UPDATE_INSTALLER_FILE} -C #{CONFIG_CACHE}/was_install"
  action :run
end

template RSP_INSTALL_PATH do
    source "was70_response_file.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
    variables({
      :profileType         => "\"cell\"",
      :installLocation     => "\'/opt/IBM/WebSphere/AppServer\'",
    })
end

template RSP_UPDATE_INSTALL_PATH do
    source "was70_response_file_update_install.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
    variables({
      :installLocation     => "\'/opt/IBM/WebSphere/UpdateInstaller\'",
    })
end

template RSP_FIXPACK27_PATH do
    source "was70_response_file_FIXPACK27.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
    variables({
      :installLocation     => "\"/opt/IBM/WebSphere/AppServer\"",
      :maintance_package     => "\"#{CONFIG_CACHE}/#{FIXPACK27_FILE}\""
    })
end

execute "Install was70" do
  user "root"
  cwd "#{CONFIG_CACHE}/was_install/WAS"
  command "./install -options #{RSP_INSTALL_PATH} -silent"
  action :run
end

execute "Install UpdateInstaller" do
  user "root"
  cwd "#{CONFIG_CACHE}/was_install/UpdateInstaller"
  command "./install -options #{RSP_UPDATE_INSTALL_PATH} -silent"
  action :run
end

execute "Aplly the fixpack27" do
  user "root"
  cwd  "#{CONFIG_CACHE}/was_install/UpdateInstaller"
  command "/opt/IBM/WebSphere/UpdateInstaller/update.sh -options #{RSP_FIXPACK27_PATH} -silent"
  action :run
end

execute "Show version installed" do
  user "root"
  command "/opt/IBM/WebSphere/AppServer/bin/versionInfo.sh"
  action :run
end

=begin

execute "Aplly the fixpack27" do
  user "root"
  cwd "#{CONFIG_CACHE}/was_install/UpdateInstaller"
  command "./install -options ../../was70_response_file_update_install.rsp -silent"
  action :run
end

execute "Create profile" do
  user "root"
  cwd WAS_BASE_INSTALLATION
  command "#{WAS_BASE_INSTALLATION}/manageprofiles.sh -create -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default -profileName #{WAS_PROFILE_NAME}"
  action :run
end

execute "Start WAS Server" do
  user "root"
  cwd WAS_BASE_INSTALLATION
  command "#{WAS_BASE_INSTALLATION}/startServer.sh server1 -profileName #{WAS_PROFILE_NAME}"
  action :run
end

if (!(File.readlines("/etc/rc.local").grep(/startServer.sh server1/).any?))
  execute "Sending start simpleServer to rc.local" do
    user "root"
    command "echo #{WAS_BASE_INSTALLATION}/startServer.sh server1 -profileName #{WAS_PROFILE_NAME} >> /etc/rc.local"
    action :run
  end
end

execute "Delete cache files" do
  user "root"
  command "rm -rf #{CONFIG_CACHE}"
  action :run
end


=end