##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Daniel Abraao Silva Costa
# Contact: dasc@br.ibm.com
#
##########################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

config_cache  = node['was8552']['cache_path']
im_tools_path = node['was8552']['im_tools_path']
im_cache_path = node['was8552']['im_cache_path']
response_path = node['was8552']['cache_path'] + "/was8552_response_file.rsp"
was_install_log = node['was8552']['cache_path'] + "/WAS8552Update.log"
was_dynamic_url1  = "http://#{$BEST_SERVER}#{node['was8552']['package1_url']}"
was_dynamic_url2  = "http://#{$BEST_SERVER}#{node['was8552']['package2_url']}"
was_package_file1 = node['was8552']['package_file1']  
was_package_file2 = node['was8552']['package_file2']


# Create the cache directories 
if (!(File.directory?("#{config_cache}")))
	directory "#{config_cache}" do
	   owner "root"
	   group "root"
	   mode "0755"
	   recursive true
	   action :create
	end
end

if (!(File.directory?("#{im_cache_path}")))
    directory "#{im_cache_path}" do
       owner "root"
       group "root"
       mode "0755"
       recursive true
       action :create
    end
end

# Download the installer packages
remote_file "#{config_cache}/#{was_package_file1}" do
  source was_dynamic_url1
end 

remote_file "#{config_cache}/#{was_package_file2}" do
 source was_dynamic_url2
end


# Uncompress the installer packages
execute "Uncompressing the package file 1 ..." do
    user "root"
    cwd config_cache
    command "unzip -o #{was_package_file1} -d #{im_cache_path}"
    action :run
end

execute "Uncompressing the package file 2 ..." do
    user "root"
    cwd config_cache
    command "unzip -o #{was_package_file2} -d #{im_cache_path}"
    action :run
end

# Preparing the response file
template response_path do
    source "was8552_response_file.rsp.erb"
    owner  'dstadmin'
    group  'dstadmin'
    mode   0755
    action :touch
end

# Apply the WAS FixPack 
execute "Updating WAS to v8.5.5.2 ..." do
  user "root"
  command "/opt/IBM/WebSphere/AppServer/bin/stopServer.sh server1 &&\
           #{im_tools_path}/imcl input #{response_path} -log #{was_install_log} -acceptLicense &&\
           /opt/IBM/WebSphere/AppServer/bin/startServer.sh server1"
  action :run
end