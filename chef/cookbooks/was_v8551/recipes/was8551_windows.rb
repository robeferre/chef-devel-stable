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

CONFIG_CACHE            = node['was8551']['cache']['path']
IM_INSTALL_LOCATION     = node['im']['installation']['path']
IM_CACHE_PATH           = node['was8551']['im']['cache']['path']
WAS_BASE_INSTALLATION   = node['was']['installation']['path']
# URL's
WAS_ZIP1_URL            = "http://#{$BEST_SERVER}#{node['was8551']['zip1_file']['url']}"
WAS_ZIP2_URL            = "http://#{$BEST_SERVER}#{node['was8551']['zip2_file']['url']}"
# FILE NAMES
WAS_ZIP_FILE1           = node['was8551']['zip1_file']['file_name']
WAS_ZIP_FILE2           = node['was8551']['zip2_file']['file_name']

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

execute "Stoping WAS Server" do
     cwd WAS_BASE_INSTALLATION
     command "stopServer.bat server1"
     action :run
end

execute "Updating Was to version 8.5.5.1" do
     cwd IM_INSTALL_LOCATION
     command "imcl install com.ibm.websphere.ND.v85_8.5.5001.20131018_2242 -repositories c:\\DST\\was8551\\ -acceptLicense"
     action :run
end

execute "Start WAS Server" do
     cwd WAS_BASE_INSTALLATION
     command "startServer.bat server1 -profileName AppSrv01" 
     action :run
end