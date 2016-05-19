##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

config_cache              = node['cache']['path']
was_installer_url         = "http://#{$BEST_SERVER}#{node['installer']['url']}"
was_update_installer_url  = "http://#{$BEST_SERVER}#{node['update_installer']['url']}"
was_fixpack27_url         = "http://#{$BEST_SERVER}#{node['fixpack27']['url']}"

WAS70_CACHE_PATH          = node['was70cache']['path']
INSTALLER_FILE            = node['installer']['file_name'] 
UPDATE_INSTALLER_FILE     = node['update_installer']['file_name'] 
FIXPACK27_FILE            = node['fixpack27']['file_name']
WAS_BASE_INSTALLATION     = node['installation']['path']
WAS_BASE_TEMPLATE         = node['template']['path']
RSP_INSTALL_PATH          = "#{WAS70_CACHE_PATH}/was70_response_file.rsp"
RSP_UPDATE_INSTALL_PATH   = "#{WAS70_CACHE_PATH}/was70_response_file_update_install.rsp"
RSP_FIXPACK27_PATH        = "#{WAS70_CACHE_PATH}/was70_response_file_fixpack27.rsp"
WAS_PROFILE_NAME          = node['profile_name']

Chef::Log.info("--- DST Installing Web Sphere 7.0.0.27 ----")


if (!(File.directory?("#{config_cache}")))
  ruby_block "hack to mkdir on windows" do
    block do
        require 'fileutils'
        FileUtils.mkdir_p "#{config_cache}"
    end
  end
end


remote_file "#{config_cache}/#{INSTALLER_FILE}" do
  source was_installer_url
  action :create_if_missing
end 


remote_file "#{config_cache}/#{UPDATE_INSTALLER_FILE}" do
   source was_update_installer_url
   action :create_if_missing
end


remote_file "#{config_cache}/#{FIXPACK27_FILE}" do
   source was_fixpack27_url 
   action :create_if_missing
end


windows_zipfile "#{config_cache}" do
    source "#{config_cache}/#{INSTALLER_FILE}"
    action :unzip
    overwrite true
end


windows_zipfile "#{config_cache}" do
    source "#{config_cache}/#{UPDATE_INSTALLER_FILE}"
    action :unzip
    overwrite true
end


template RSP_INSTALL_PATH do
    source "was70_response_file.rsp.erb"
    action :touch
    variables({
      :profileType         => "\"standAlone\"",
      :installLocation     => "\"C:\\Program Files\\IBM\\WebSphere\\AppServer\"",
    })
end


execute "Install was70" do
  #cwd "C:\\tmp\\chef-solo\\was70\\WAS"
  command "C:\\tmp\\chef-solo\\was70\\WAS\\install.exe -options C:\\tmp\\chef-solo\\was70\\was70_response_file.rsp -silent"
  action :run
end


template RSP_UPDATE_INSTALL_PATH do
    source "was70_response_file_update_install.rsp.erb"
    action :touch
    variables({
      :installLocation     => "\"C:\\Program Files\\IBM\\WebSphere\\UpdateInstaller\"",
    })
end


execute "Install UpdateInstaller" do
  #cwd "C:\\tmp\\chef-solo\\was70\\UpdateInstaller\\"
  command "C:\\tmp\\chef-solo\\was70\\UpdateInstaller\\install.exe -options C:\\tmp\\chef-solo\\was70\\was70_response_file_update_install.rsp -silent"
  action :run
end


template RSP_FIXPACK27_PATH do
    source "was70_response_file_FIXPACK27.rsp.erb"
    action :touch
    variables({
      :installLocation       => "\"C:\\Program Files\\IBM\\WebSphere\\AppServer\"",
      :maintance_package     => "\"C:\\tmp\\chef-solo\\was70\\7.0.0-WS-WAS-WinX64-FP0000027.pak\""
    })
end


execute "Aplly the fixpack27" do
  cwd "C:\\Program Files\\IBM\\WebSphere\\UpdateInstaller\\"
  command "update.bat -options C:\\tmp\\chef-solo\\was70\\was70_response_file_fixpack27.rsp -silent"
  action :run
end


execute "Show version installed" do
  cwd "C:\\Program Files\\IBM\\WebSphere\\AppServer\\bin\\"
  command "versionInfo.bat"
  action :run
end

=begin

execute "Install UpdateInstaller" do
  cwd "#{config_cache}\\UpdateInstaller"
  command "install.exe -options #{RSP_UPDATE_INSTALL_PATH} -silent"
  action :run
end

execute "Aplly the fixpack27" do
  user "root"
  cwd  "#{CONFIG_CACHE}/was_install/UpdateInstaller"
  command "/opt/IBM/WebSphere/UpdateInstaller/update.sh -options #{RSP_FIXPACK27_PATH} -silent"
  action :run
end

execute "Show version installed" do
  command "/opt/IBM/WebSphere/AppServer/bin/versionInfo.sh"
  action :run
end


template RESPONSE_FILE_PATH do
    source "was70_response_file.rsp.erb"
    action :touch
    variables({
      :repository_location => "\'C:\\DST\\was_v85\'",
      :installLocation     => "\'C:\\Program Files (x86)\\IBM\\WebSphere\\AppServer\'",
      :eclipseLocation     => "\'C:\\Program Files (x86)\\IBM\\WebSphere\\AppServer\'",
      :os                  => "\'win32\'",
      :arch                => "\'x86\'",
      :ws                  => "\'win32\'",
      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
end

execute "Install WAS" do
  cwd IM_INSTALL_LOCATION
  command "imcl.exe input #{RESPONSE_FILE_PATH} -log C:/tmp/install_log.xml -acceptLicense"
  action :run
end

if (!(File.exists?('C:/Program Files (x86)/IBM/WebSphere/AppServer/Profiles/AppSrv01')))
  execute "Create profile" do
    cwd WAS_BASE_INSTALLATION
    command  "manageprofiles.bat -create -templatePath \"#{WAS_BASE_TEMPLATE}\" -profileName #{WAS_PROFILE_NAME}" 
    action :run
  end
end

execute "Starting WAS Server" do
  cwd WAS_BASE_INSTALLATION
  command "startServer.bat server1 -profileName #{WAS_PROFILE_NAME}"
  action :run
end

execute "Delete Zip Files" do
  cwd config_cache
  command "del *.zip /q"
  action :run
end


=end