###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
CONFIG_MOUNT 	= node['bpm8000']['config']['mount']
BPM_ZIP_FILE1 	= node['bpm8000']['zip']['file1']
BPM_ZIP_FILE2 	= node['bpm8000']['zip']['file2']
BPM_ZIP_FILE3 	= node['bpm8000']['zip']['file3']
BPM_ZIP_FILE4 	= node['bpm8000']['zip']['file4']
BPM_ZIP_FILE5 	= node['bpm8000']['zip']['file5']
BPM_ZIP_FILE6 	= node['bpm8000']['zip']['file6']
BPM_ZIP_FILE7 	= node['bpm8000']['zip']['file7']
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location1']}"
ihs_dynamic_url_file2 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location2']}"
ihs_dynamic_url_file3 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location3']}"
ihs_dynamic_url_file4 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location4']}"
ihs_dynamic_url_file5 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location5']}"
ihs_dynamic_url_file6 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location6']}"
ihs_dynamic_url_file7 = "http://#{$BEST_SERVER}#{node['bpm8000']['zip']['location7']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

#if (!(File.directory?(node['bpm8000']['config']['cache'])))

	log "---DST - Create the directory #{node['bpm8000']['config']['mount']}----" 
 
	directory node['bpm8000']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
	log "----DST - Create the directory #{node['bpm8000']['config']['cache']}----" 

	directory node['bpm8000']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  

	##################################
	#
	# copy /install in mount_path
	#
	##################################

	log "-----DST - Get the BPM V8000 zip 1 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}" do
	source ihs_dynamic_url_file1
	action :create_if_missing
	end
		
	log "-----DST - Get the BPM V8000 zip 2 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE2}" do
	source ihs_dynamic_url_file2
	action :create_if_missing
	end

	log "-----DST - Get the BPM V8000 zip 3 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE3}" do
	source ihs_dynamic_url_file3
	action :create_if_missing
	end

	log "-----DST - Get the BPM V8000 zip 4 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE4}" do
	source ihs_dynamic_url_file4
	action :create_if_missing
	end

	log "-----DST - Get the BPM V8000 zip 5 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE5}" do
	source ihs_dynamic_url_file5
	action :create_if_missing
	end

	log "-----DST - Get the BPM V8000 zip 6 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE6}" do
	source ihs_dynamic_url_file6
	action :create_if_missing
	end

	log "-----DST - Get the BPM V8000 zip 7 file----"

	remote_file "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE7}" do
	source ihs_dynamic_url_file7
	action :create_if_missing
	end

	##################################
	#
	# unzip in cache_path
	#
	##################################

	log "---- DST - Unzip the Websphere MQ zip file 1----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE1}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 2----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE2}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 3----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE3}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 4----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE4}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 5----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE5}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 6----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE6}"
	  action :unzip
	  overwrite true
	end

	log "---- DST - Unzip the Websphere MQ zip file 7----" 

	windows_zipfile "#{node['bpm8000']['config']['cache']}" do
	  source "#{CONFIG_MOUNT}/#{BPM_ZIP_FILE7}"
	  action :unzip
	  overwrite true
	end
	
	Chef::Log.info("Delete Zip files")
	
	directory CONFIG_MOUNT do
	rights :full_control,'Administrator'
	recursive true
	action :delete
	end
#else

 # log "IBM Business Process Manager package file is already downloaded" do
 # level :info
 # end

#end

