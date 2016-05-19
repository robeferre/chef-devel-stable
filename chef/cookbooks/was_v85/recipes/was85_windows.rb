##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
##########################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

# PATHS
IM_INSTALL_LOCATION     = node['im']['installation']['path']
IM_CACHE_PATH           = node['im']['cache']['path']
CONFIG_CACHE            = node['was85']['cache']['path']
WAS_BASE_INSTALLATION   = node['was85']['installation']['path']
WAS_BASE_TEMPLATE       = node['was85']['template']['path']
RESPONSE_FILE_PATH      = "#{IM_CACHE_PATH}/was85_response_file.rsp"
# URL's
WAS_ZIP1_URL            = "http://#{$BEST_SERVER}#{node['was85']['zip1_file']['url']}"
WAS_ZIP2_URL            = "http://#{$BEST_SERVER}#{node['was85']['zip2_file']['url']}"
WAS_ZIP3_URL            = "http://#{$BEST_SERVER}#{node['was85']['zip3_file']['url']}"
# FILE NAMES
WAS_ZIP_FILE1           = node['was85']['zip1_file']['file_name']  
WAS_ZIP_FILE2           = node['was85']['zip2_file']['file_name']  
WAS_ZIP_FILE3           = node['was85']['zip3_file']['file_name']  
# PROFILE
WAS_PROFILE_NAME        = node['was85']['profile_name']

Chef::Log.info("Installing Web Sphere 8.5.0")
  
if (!(File.directory?("#{CONFIG_CACHE}")))
  ruby_block "hack to mkdir on windows" do
    block do
        require 'fileutils'
        FileUtils.mkdir_p "#{CONFIG_CACHE}"
    end
  end
end

if (!(File.directory?("#{IM_CACHE_PATH}")))
  ruby_block "hack to mkdir on windows" do
    block do
        require 'fileutils'
        FileUtils.mkdir_p "#{IM_CACHE_PATH}"
    end
  end
end

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE1}" do
   source WAS_ZIP1_URL
   checksum node['was85']['zip1_file']['checksum']
   not_if { ::File.exists?("#{CONFIG_CACHE}/#{WAS_ZIP_FILE1}") }
end 

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE2}" do
   source WAS_ZIP2_URL
   checksum node['was85']['zip2_file']['checksum']
   not_if { ::File.exists?("#{CONFIG_CACHE}/#{WAS_ZIP_FILE2}") }
end 

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE3}" do
   source WAS_ZIP3_URL
   checksum node['was85']['zip3_file']['checksum']
   not_if { ::File.exists?("#{CONFIG_CACHE}/#{WAS_ZIP_FILE3}") }
end 

windows_zipfile "#{IM_CACHE_PATH}" do
    source "#{CONFIG_CACHE}/#{WAS_ZIP_FILE1}"
    action :unzip
    overwrite true
end

windows_zipfile "#{IM_CACHE_PATH}" do
    source "#{CONFIG_CACHE}/#{WAS_ZIP_FILE2}"
    action :unzip
    overwrite true
end

windows_zipfile "#{IM_CACHE_PATH}" do
    source "#{CONFIG_CACHE}/#{WAS_ZIP_FILE3}"
    action :unzip
    overwrite true
end

template RESPONSE_FILE_PATH do
    source "was85_response_file.rsp.erb"
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
  cwd CONFIG_CACHE
  command "del *.zip /q"
  action :run
end