###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
RESPONSE_FILE_PATH = "#{node['bpm8012']['config']['cache']}/#{node['bpm8012']['respfile']['bpm']}"

CONFIG_MOUNT 	= node['bpm8012']['config']['mount']
BPM_ZIP_FILE1 	= node['bpm8012']['zip']['file1']
BPM_ZIP_FILE2 	= node['bpm8012']['zip']['file2']

ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['bpm8012']['zip']['location1']}"

 ##########################################################
 #
 # Update the was version if needed
 #
 ##########################################################
   
 include_recipe 'was_nd_8007::install'

  
   ######################################################
   #
   # create Cache_path and unzip the product package file
   #
   ######################################################
  log "---DST - Create the directory #{node['bpm8012']['config']['mount']}----" 
 
	directory node['bpm8012']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
 log "----DST - Create the directory #{node['bpm8012']['config']['cache']}----" 

	directory node['bpm8012']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   



  log "-----DST - Get the BPM V8012 zip 1 file----"

  remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}" do
    source ihs_dynamic_url_file
    action :create_if_missing
  end
		
  log "---- DST - Unzip the BPM V8012 zip file 1 ----" 

  windows_zipfile "#{node['bpm8012']['config']['cache']}" do
    source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}"
    action :unzip
    overwrite true
  end
  

   ##################################
   #
   # Create response file
   #
   ##################################
   if (!(File.exists?(RESPONSE_FILE_PATH)))
     log " ----DST - Create a reponse file -----"

    template "#{RESPONSE_FILE_PATH}" do
      source node['bpm8012']['resperb']['bpm']	
      action :touch
      variables({
	      :repository_location => "\'C:\\DST\\bpm8012_base_install\\unzip\'",
	      :installLocation     => "\'C:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'C:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
     end
  end

    log " -------DST - Installation of BPM -------"

    execute "Install BPM 8012" do
      cwd node['im']['base']['path']
      command "imcl.exe input #{RESPONSE_FILE_PATH} -log C:/tmp/install_bpm8012_log.xml -acceptLicense"
      action :run
    end

 Chef::Log.info("Delete Zip files")
   execute "Delete Zip Files" do
    cwd node['bpm8012']['config']['mount']
    command "del *.zip /q"
    action :run
   end
