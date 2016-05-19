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
  directory "#{CONFIG_CACHE}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

if (!(File.directory?("#{IM_CACHE_PATH}")))
  directory "#{IM_CACHE_PATH}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE1}" do
  source WAS_ZIP1_URL
  checksum node['was85']['zip1_file']['checksum']
end 

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE2}" do
   source WAS_ZIP2_URL
   checksum node['was85']['zip2_file']['checksum']
end

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE3}" do
   source WAS_ZIP3_URL 
   checksum node['was85']['zip3_file']['checksum']
end

execute "Unzip WAS File 1" do
  user "root"
  cwd CONFIG_CACHE
  command "unzip -o #{WAS_ZIP_FILE1} -d #{IM_CACHE_PATH}"
  action :run
end

execute "Unzip WAS File 2" do
  user "root"
  cwd CONFIG_CACHE
  command "unzip -o #{WAS_ZIP_FILE2} -d #{IM_CACHE_PATH}"
  action :run
end

execute "Unzip WAS File 3" do
  user "root"
  cwd CONFIG_CACHE
  command "unzip -o #{WAS_ZIP_FILE3} -d #{IM_CACHE_PATH}"
  action :run
end
  
template RESPONSE_FILE_PATH do
    source "was85_response_file.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
    variables({
      :repository_location => "\'#{IM_CACHE_PATH}\'",
      :installLocation     => "\'/opt/IBM/WebSphere/AppServer\'",
      :eclipseLocation     => "\'/opt/IBM/WebSphere/AppServer\'",
      :os                  => "\'linux\'",
      :arch                => "\'x86\'",
      :ws                  => "\'gtk\'",
      :eclipseCache        => "\'/opt/IBM/IMShared\'"
    })
end

execute "Install WAS85" do
  user "root"
  cwd IM_INSTALL_LOCATION
  command "#{IM_INSTALL_LOCATION}/imcl input #{RESPONSE_FILE_PATH} -log /var/tmp/install_log.xml -acceptLicense"
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

=begin
execute "Delete cache files" do
  user "root"
  command "rm -rf #{CONFIG_CACHE}"
  action :run
end
=end