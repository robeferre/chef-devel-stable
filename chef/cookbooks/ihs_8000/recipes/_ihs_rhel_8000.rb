###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# IHS Server (HTTP SERVER)
#
###########################################################################################################################################
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['ihs8000']['zip']['location1']}"
ihs_dynamic_url_file2 = "http://#{$BEST_SERVER}#{node['ihs8000']['zip']['location2']}"
ihs_dynamic_url_file3 = "http://#{$BEST_SERVER}#{node['ihs8000']['zip']['location3']}"
ihs_dynamic_url_file4 = "http://#{$BEST_SERVER}#{node['ihs8000']['zip']['location4']}"
#############################
#
# create Cache_path for IHS
#
#############################

# Testing if the IHS is already installed
if (!(File.exists?(node['ihs8000']['base']['path'])&& File.directory?(node['ihs8000']['base']['path'])))

	log "-------------DST Create the directory cache path #{node['ihs8000']['config']['mount']}-----------"
 
	directory node['ihs8000']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

	log "-------------DST Create the directory cache path #{node['ihs8000']['config']['cache']}-----------"

	directory node['ihs8000']['config']['cache'] do
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
	log "-------------DST Get the WAS zip 1 file-----------" 

	remote_file "#{node['ihs8000']['config']['mount']}/#{node['ihs8000']['zip']['file1']}" do
	source ihs_dynamic_url_file1
	action :create_if_missing
	end
	
	log "-------------DST Get the WAS zip 2 file-----------" 

	remote_file "#{node['ihs8000']['config']['mount']}/#{node['ihs8000']['zip']['file2']}" do
	source ihs_dynamic_url_file2
	action :create_if_missing
	end

	log "-------------DST Get the WAS zip 3 file-----------" 

	remote_file "#{node['ihs8000']['config']['mount']}/#{node['ihs8000']['zip']['file3']}" do
	source ihs_dynamic_url_file3
	action :create_if_missing
	end

	log "-------------DST Get the WAS zip 4 file-----------" 

	remote_file "#{node['ihs8000']['config']['mount']}/#{node['ihs8000']['zip']['file4']}" do
	source ihs_dynamic_url_file4
	action :create_if_missing
	end

	################################
	#
	# unzip install files
	#
	################################
	
	log "-------------DST Unzip the IHS zip file 1-----------" 

	execute "Unzip IHS File 1" do
	  user "root"
	  cwd node['ihs8000']['config']['mount']
	  command "unzip -o #{node['ihs8000']['zip']['file1']} -d #{node['ihs8000']['config']['cache']}"
	  action :run
	end

	log "-------------DST Unzip the IHS zip file 2-----------" 

	execute "Unzip IHS File 2" do
	  user "root"
	  cwd node['ihs8000']['config']['mount']
	  command "unzip -o #{node['ihs8000']['zip']['file2']} -d #{node['ihs8000']['config']['cache']}"
	  action :run
	end

	log "-------------DST Unzip the IHS zip file 3-----------" 

	# Unzip the WAS zip3 file
	execute "Unzip IHS File 3" do
	  user "root"
	  cwd node['ihs8000']['config']['mount']
	  command "unzip -o #{node['ihs8000']['zip']['file3']} -d #{node['ihs8000']['config']['cache']}"
	  action :run
	end

	log "-------------DST Unzip the IHS zip file 4-----------" 

	# Unzip the WAS zip4 file
	execute "Unzip IHS File 4" do
	  user "root"
	  cwd node['ihs8000']['config']['mount']
	  command "unzip -o #{node['ihs8000']['zip']['file4']} -d #{node['ihs8000']['config']['cache']}"
	  action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['ihs8000']['config']['mount']}/#{node['ihs8000']['response']['file']}" do
	source "#{node['ihs8000']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	variables({ :cache_path => node['ihs8000']['config']['cache']}) 
	action :create_if_missing
	end

	####################################
	#
	# install IHS silently
	#
	####################################
	log "-------------DST install ihs silently-----------"

	execute "Install IHS" do
	 cwd node['im']['base']
	 command "./imcl -acceptLicense -input #{node['ihs8000']['config']['mount']}/#{node['ihs8000']['response']['file']} -log #{node['ihs8000']['log']['file']}"
	 action :run
	end

	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['ihs8000']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   


else

  log "a version of IBM HTTP Server already installed or a HTTP folder already exist!" do
  level :info
  end

end



