###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM Tivoli Directory Server 6.3
#
###########################################################################################################################################
tdsfp24_dynamic_url_file = "http://#{$BEST_SERVER}#{node['tdsfp24']['zip']['location']}"

include_recipe 'FileNet_P8_52::tds_rhel_63'

#############################
#
# create Cache_path for P8 doc
#
#############################

log "-------------DST Create the directory cache path #{node['tdsfp24']['config']['mount']}-----------"
 
	directory node['tdsfp24']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "---DST Create the directory cache path #{node['tdsfp24']['config']['cache']}---"

	directory node['tdsfp24']['config']['cache'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 recursive true
	 action :create
	end   
  
  

	#############################
	#
	# copy /install in cache_path
	#
	#############################
log "------DST Get the FileNet Documentation zip file----" 

	remote_file "#{node['tdsfp24']['config']['mount']}/#{node['tdsfp24']['zip']['file']}" do
	source tdsfp24_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	log "--DST -Unzip the dtsfp24 gzip file --"
	
	execute "extract Gzip dst FP24 file.tar.gz " do
	  user "root"
	  cwd node['tdsfp24']['config']['mount']
	  command " gzip -d #{node['tdsfp24']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the TDS zip file 1-----" do
	   level :info
	end

	execute "Untar tds" do
    	user "root"
    	cwd node['tdsfp24']['config']['cache']
    	command "tar -xvf #{node['tdsfp24']['config']['mount']}/#{node['tdsfp24']['tar']['file']}"
   	   action :run
	end

	####################################
	#
	# install FileNet P8 dst silently
	#
	####################################


	execute "accept license" do
	 cwd node['tdsfp24']['base']['path']
	 command "license/idsLicense -q"
	 action :run
	end

	execute "Install FP24" do
	 cwd node['tdsfp24']['base']['path']
	 command "./idsinstall -u"
	 action :run
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['tdsfp24']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

