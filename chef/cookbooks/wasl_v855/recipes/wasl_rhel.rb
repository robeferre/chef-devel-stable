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

CONFIG_CACHE            = node['wasl']['config']['cache']['path']
IM_INSTALL_LOCATION     = node['im']['installation']['path']
IM_CACHE_PATH           = node['im']['cache']['path']
WASL_ZIP_URL            = "http://#{$BEST_SERVER}#{node['wasl']['file']['zip']['url']}"
WASL_ZIP_FILE           = node['wasl']['file']['zip']['file_name']
RESPONSE_FILE_PATH      = "#{IM_CACHE_PATH}/wasl_response_file.rsp"
LOG_PATH                = "#{CONFIG_CACHE}/waslsetup.log"

if (!(File.directory?("#{CONFIG_CACHE}")))
  directory "#{CONFIG_CACHE}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

remote_file "#{CONFIG_CACHE}/#{WASL_ZIP_FILE}" do
    source WASL_ZIP_URL
    checksum node['wasl']['file']['zip']['checksum']
    owner 'dstadmin'
    group 'dstadmin'
    mode 0755
    action :create
end

directory "#{IM_CACHE_PATH}" do
    owner "dstadmin"
    group "dstadmin"
    mode 0755
    recursive true
    action :create
end

execute "Unzip #{WASL_ZIP_FILE}" do
  user "root"
  cwd CONFIG_CACHE
  command "unzip -o #{WASL_ZIP_FILE} -d #{IM_CACHE_PATH}"
  action :run
end

template RESPONSE_FILE_PATH do
    source "wasl_response_file.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
    variables({
      :repository_location => "\'#{IM_CACHE_PATH}\'",
      :installLocation     => "\'/opt/IBM/WebSphere/Liberty\'",
      :eclipseLocation     => "\'/opt/IBM/WebSphere/Liberty\'",
      :os                  => "\'linux\'",
      :arch                => "\'x86\'",
      :ws                  => "\'gtk\'",
      :eclipseCache        => "\'/opt/IBM/IMShared\'"
    })
end

execute "Install WASL" do
  user "root"
  cwd IM_INSTALL_LOCATION
  command "#{IM_INSTALL_LOCATION}imcl input #{RESPONSE_FILE_PATH} -log #{LOG_PATH} -acceptLicense" 
  action :run
end

execute "Creating Simple Server" do
  user "root"
  command "/opt/IBM/WebSphere/Liberty/bin/server create simpleServer"
  action :run
end

if (!(File.readlines("/etc/rc.local").grep(/simpleServer/).any?))
  execute "Sending start simpleServer to rc.local" do
    user "root"
    cwd IM_INSTALL_LOCATION
    command "echo /opt/IBM/WebSphere/Liberty/bin/server start simpleServer >> /etc/rc.local"
    action :run
  end
end

execute "Delete cached files" do
  user "root"
  command "rm -rf #{CONFIG_CACHE}"
  action :run
end