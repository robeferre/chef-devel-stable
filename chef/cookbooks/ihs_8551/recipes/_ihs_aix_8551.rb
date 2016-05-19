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
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['ihs8551']['zip']['location1']}"
ihs_dynamic_url_file2 = "http://#{$BEST_SERVER}#{node['ihs8551']['zip']['location2']}"

#############################
#
# create Cache_path for IHS
#
#############################


	log "Create the directory cache path #{node['ihs8551']['config']['mount']}" do
		level :info
	end
 
	directory node['ihs8551']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 recursive true
	 action :create
	end   
  
	log "Create the directory cache path #{node['ihs8551']['config']['cache']}" do
		level :info
	end
 
	directory node['ihs8551']['config']['cache'] do
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
	log "Get the WAS FP0000001 zip 1 file" do
	level :info
	end

	remote_file "#{node['ihs8551']['config']['mount']}/#{node['ihs8551']['zip']['file1']}" do
	source ihs_dynamic_url_file1
	action :create_if_missing
	end
	
	log "Get the WAS FP0000001 zip 2 file" do
	level :info
	end

	remote_file "#{node['ihs8551']['config']['mount']}/#{node['ihs8551']['zip']['file2']}" do
	source ihs_dynamic_url_file2
	action :create_if_missing
	end


	################################
	#
	# unzip install files
	#
	################################
	
	log "Unzip the IHS zip file 1" do
	   level :info
	end

	execute "Unzip IHS File 1" do
	  user "root"
	  cwd node['ihs8551']['config']['mount']
	  command "unzip -o #{node['ihs8551']['zip']['file1']} -d #{node['ihs8551']['config']['cache']}"
	  action :run
	end

	log "Unzip the IHS zip file 2" do
	   level :info
	end

	execute "Unzip IHS File 2" do
	  user "root"
	  cwd node['ihs8551']['config']['mount']
	  command "unzip -o #{node['ihs8551']['zip']['file2']} -d #{node['ihs8551']['config']['cache']}"
	  action :run
	end
	
	######################################
	#
	# Create a reponse file
	#
	######################################
	log "Create a reponse file" do 
	   level :info
	end
	
	template "#{node['ihs8551']['config']['cache']}/#{node['ihs8551']['response']['file']}" do
	source "#{node['ihs8551']['response']['erb']}"
	owner  'root'
	mode   '0600'
	variables({ :cache_path => node['ihs8551']['config']['cache']}) 
	action :create_if_missing
	end

	
	####################################
	#
	# install IHS FP0000001
	#
	####################################
	log "install ihs FP0000001" do
	  level :info
	end

	execute "Install IHS FP0000001" do
	 cwd node['im']['base']
	 command "./imcl -acceptLicense -input #{node['ihs8551']['config']['cache']}/#{node['ihs8551']['response']['file']} -log #{node['ihs8551']['log']['file']}"
	 action :run
	end

	#######################################
	#
	# Start IHS 
	#
	#######################################

	log " Start IHS " do 
	  level :info
	end

	execute "Start IHS Server" do
	  user "root"
	  cwd node['ihs8551']['base']['path']
	  command "#{node['ihs8551']['base']['path']}/bin/apachectl start"
	  action :run
	end


	####################################################################
	#
	# Add Http start in initab
	#
	#####################################################################

	log "-------------DST Add http start in inittab -----------" do 
	  level :info
	end
	
	if (!(File.readlines("/etc/inittab").grep(/apachectl start/).any?))
		execute "Add http start in initttab" do
		  user "root"
		  cwd node['ihs8550']['base']['path']
		  command "mkitab 'ihshttpd:2:once:/usr/IBM/HTTPServer/bin/apachectl start > /dev/console 2>&1'"
		  action :run
		end
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################
	log "remove cache directory" do
	 level :info
	end
	directory node['ihs8551']['config']['mount'] do
	  owner "root"
	  recursive true
	  action :delete
	end   


