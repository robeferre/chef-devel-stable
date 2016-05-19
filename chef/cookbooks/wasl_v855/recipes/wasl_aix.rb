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
     group "wheel"
     mode "0755"
     recursive true
     action :create
  end   
end

if (!(File.directory?("#{IM_CACHE_PATH}")))
  directory "#{IM_CACHE_PATH}" do
     owner "root"
     group "wheel"
     mode "0755"
     recursive true
     action :create
  end   
end

remote_file "#{CONFIG_CACHE}/#{WASL_ZIP_FILE}" do
    source WASL_ZIP_URL
    checksum node['wasl']['file']['zip']['checksum']
    owner 'root'
    group 'wheel'
    mode 0755
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
    owner  'root'
    group  'wheel'
    mode   0755
    action :touch
    variables({
      :repository_location => "\'#{IM_CACHE_PATH}\'",
      :installLocation     => "\'/usr/IBM/WebSphere/Liberty\'",
      :eclipseLocation     => "\'/usr/IBM/WebSphere/Liberty\'",
      :os                  => "\'aix\'",
      :arch                => "\'ppc\'",
      :ws                  => "\'motif\'",
      :eclipseCache        => "\'/usr/IBM/IMShared\'"
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
  command "/usr/IBM/WebSphere/Liberty/bin/server create simpleServer"
  action :run
end

execute "Sending start server to /etc/inittab" do
  user "root"
  cwd IM_INSTALL_LOCATION
  command "echo /usr/IBM/WebSphere/Liberty/bin/server create simpleServer >> /etc/inittab"
  action :run
end