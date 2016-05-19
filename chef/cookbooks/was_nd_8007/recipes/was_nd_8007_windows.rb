###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
CONFIG_MOUNT 	= node['was8007']['config']['mount']
BPM_ZIP_FILE1 	= node['was8007']['zip']['file1']
BPM_ZIP_FILE2 	= node['was8007']['zip']['file2']

RESPONSE_FILE_PATH = "#{node['was8007']['config']['cache']}/#{node['was8007']['response']['file']}"

#######################################
#
# create Cache_path for WAS ND
#
#######################################

log "---DST - Create the directory #{CONFIG_MOUNT}----" 
 
	directory CONFIG_MOUNT do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
log "----DST - Create the directory #{node['was8007']['config']['cache']}----" 

	directory node['was8007']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
  

##################################
#
# copy /install in cache_path
#
##################################
log "-----DST - Get the WAS ND V8007 zip 1 file----"

remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}" do
	source node['was8007']['zip']['location1']
	action :create_if_missing
end
	
log "-----DST - Get the WAS ND V8007 zip 2 file----"

remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE2}" do
  source node['was8007']['zip']['location2']
  action :create_if_missing
end
		
log "---- DST - Unzip the WAS ND 8007 zip file 1 ----" 

windows_zipfile "#{node['was8007']['config']['cache']}" do
  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}" 
  action :unzip
  overwrite true
end

log "---- DST - Unzip the WAS ND 8007 zip file 2 ----" 

windows_zipfile "#{node['was8007']['config']['cache']}" do
  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE2}"
  action :unzip
  overwrite true
end

class Chef::Recipe
  include Helper_bpm_80
end

if bpm_installation_directory == true
  if (!(File.exists?(RESPONSE_FILE_PATH)))
	log " ----DST - Create a reponse file WAS for BPM-----"

	template "#{RESPONSE_FILE_PATH}" do
    		source node['was8007']['response']['erb']
    		action :touch
    		variables({
      		:repository_location => "\'C:\\DST\\was_nd_8007_base_install\\unzip\'",
      		:installLocation     => "\'C:\\BPM\\V8.0\'",
      		:eclipseLocation     => "\'C:\\BPM\\V8.0\'",
      		:os                  => "\'win32\'",
      		:arch                => "\'x86\'",
      		:ws                  => "\'win32\'",
      		:eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    		})
	end
  end
else 
	log " ----DST - Create a reponse file WAS-----"

	template "#{RESPONSE_FILE_PATH}" do
    		source node['was8007']['response']['erb']
    		action :touch
    		variables({
      		:repository_location => "\'C:\\DST\\was_nd_8007_base_install\\unzip\'",
      		:installLocation     => "\'C:\\Program Files (x86)\\IBM\\WebSphere\\AppServer\'",
      		:eclipseLocation     => "\'C:\\Program Files (x86)\\IBM\\WebSphere\\AppServer\'",
      		:os                  => "\'win32\'",
      		:arch                => "\'x86\'",
      		:ws                  => "\'win32\'",
      		:eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    		})
	end
end


log " -------DST - Installation ofWAS ND 8007 -------"

execute "Install WAS ND 8007" do
  cwd node['im']['base']['path']
  command "imcl.exe input #{RESPONSE_FILE_PATH} -log C:/tmp/install_wasND8007_log.xml -acceptLicense"
  action :run
end

log " -------DST - Delete mount path -------"

directory CONFIG_MOUNT do
  rights :full_control,'Administrator'
  recursive true
  action :delete
end   