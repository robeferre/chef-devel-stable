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
# URL's
WAS_ZIP1_URL            = "http://#{$BEST_SERVER}#{node['was8551']['zip1_file']['url']}"
WAS_ZIP2_URL            = "http://#{$BEST_SERVER}#{node['was8551']['zip2_file']['url']}"
# FILE NAMES
WAS_ZIP_FILE1           = node['was8551']['zip1_file']['file_name']  
WAS_ZIP_FILE2           = node['was8551']['zip2_file']['file_name']

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

execute "Updating was to v8.5.5.1 " do
    user "root"
    command "/opt/IBM/WebSphere/AppServer/bin/stopServer.sh server1 &&\
            /opt/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.websphere.ND.v85_8.5.5001.20131018_2242 -repositories /DST/was8551/ -acceptLicense &&\
            /opt/IBM/WebSphere/AppServer/bin/startServer.sh server1"
    action :run
end