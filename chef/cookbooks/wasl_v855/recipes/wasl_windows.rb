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

class Chef::Recipe
  include Helper
end

CONFIG_CACHE            = node['wasl']['config']['cache']['path']
IM_INSTALL_LOCATION     = node['im']['installation']['path']
IM_CACHE_PATH           = node['wasl']['im']['cache']['path']
WASL_ZIP_URL            = "http://#{$BEST_SERVER}#{node['wasl']['file']['zip']['url']}"
WASL_ZIP_FILE           = node['wasl']['file']['zip']['file_name']
RESPONSE_FILE_PATH      = "#{CONFIG_CACHE}/wasl_response_file.rsp"
LOG_PATH                = "#{CONFIG_CACHE}/waslsetup.log"

if (!(File.directory?("#{CONFIG_CACHE}")))
  ruby_block "hack to mkdir on windows" do
    block do
        require 'fileutils'
        FileUtils.mkdir_p "#{CONFIG_CACHE}"
    end
  end
end

if (!(File.directory?("#{CONFIG_CACHE}/unzip")))
  ruby_block "hack to mkdir on windows" do
    block do
        require 'fileutils'
        FileUtils.mkdir_p "#{CONFIG_CACHE}/unzip"
    end
  end
end

remote_file "#{CONFIG_CACHE}/#{WASL_ZIP_FILE}" do
    source WAS_ZIP1_URL
    checksum node['wasl']['file']['zip']['checksum']
    action :create
end 
  
windows_zipfile "#{CONFIG_CACHE}/unzip" do
  source "#{CONFIG_CACHE}/#{WASL_ZIP_FILE}"
  action :unzip
  overwrite true
end
  
template RESPONSE_FILE_PATH do
    source "wasl_windows.rsp.erb"
    action :touch
    variables({
      :repository_location => "\'#{CONFIG_CACHE}/unzip\'",
      :installLocation     => "\'/usr/WebSphere/Liberty\'",
      :eclipseLocation     => "\'/usr/WebSphere/Liberty\'",
      :os                  => "\'aix\'",
      :arch                => "\'ppc64\'",
      :ws                  => "\'gtk\'",
      :eclipseCache        => "\'/usr/IMShared'\'"
    })
end

execute "Install WASL" do
  cwd IM_INSTALL_LOCATION
  command "#{IM_INSTALL_LOCATION}/imcl input #{RESPONSE_FILE_PATH} -log #{LOG_PATH} -acceptLicense " +
  'C:\Program Files (x86)\IBM\WebSphere\Liberty\bin\Server ' + "create simpleServer"
  action :run
end
