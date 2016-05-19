##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

# PATHS
IM_INSTALL_LOCATION     = node['im']['base']['path']	
IM_CACHE_PATH           = node['was8007']['config']['cache']
CONFIG_CACHE            = node['was8007']['config']['mount']
RESPONSE_FILE_PATH      = "#{IM_CACHE_PATH}/was80_response_file.rsp"
# URL's
WAS_ZIP1_URL            = "http://#{$BEST_SERVER}#{node['was8007']['zip']['location1']}"
WAS_ZIP2_URL            = "http://#{$BEST_SERVER}#{node['was8007']['zip']['location2']}"

# FILE NAMES
WAS_ZIP_FILE1           = node['was8007']['zip']['file1'] 
WAS_ZIP_FILE2           = node['was8007']['zip']['file2']	



Chef::Log.info("Installing Web Sphere 8.0.0.7")

directory "#{CONFIG_CACHE}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create 
end

directory "#{IM_CACHE_PATH}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create 
end

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE1}" do
  source WAS_ZIP1_URL
end 

remote_file "#{CONFIG_CACHE}/#{WAS_ZIP_FILE2}" do
   source WAS_ZIP2_URL
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


template RESPONSE_FILE_PATH do
    source "was_nd_8007_resp.xml.erb"
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

execute "Updating was to v8.0.0.7 " do
    user "root"
    command "/opt/IBM/WebSphere/AppServer/bin/stopServer.sh server1 &&\
            /opt/IBM/InstallationManager/eclipse/tools/imcl input #{RESPONSE_FILE_PATH} -log /var/tmp/install_log.xml -acceptLicense &&\
            /opt/IBM/WebSphere/AppServer/bin/startServer.sh server1"
    action :run
end

log "-------------DST remove cache directory-----------" do
	 level :info
	end
	directory node['was8007']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   
