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
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['ihs8004']['zip']['location1']}"
ihs_dynamic_url_file2 = "http://#{$BEST_SERVER}#{node['ihs8004']['zip']['location2']}"

	#############################
	#
	# create Cache_path for IHS
	#
	#############################

	log "-------------DST Create the directory cache path #{node['ihs8004']['config']['mount']}-----------" do
		level :info
	end
 
	directory node['ihs8004']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

	log "-------------DST Create the directory cache path #{node['ihs8004']['config']['cache']}-----------" do
		level :info
	end

	directory node['ihs8004']['config']['cache'] do
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
	log "------DST Get the WAS FP0000004 zip 1 file-----" do
	level :info
	end

	remote_file "#{node['ihs8004']['config']['mount']}/#{node['ihs8004']['zip']['file1']}" do
	source ihs_dynamic_url_file1
	action :create_if_missing
	end
	
	log "------DST Get the WAS FP0000004 zip 2 file-----" do
	level :info
	end

	remote_file "#{node['ihs8004']['config']['mount']}/#{node['ihs8004']['zip']['file2']}" do
	source ihs_dynamic_url_file2
	action :create_if_missing
	end


	################################
	#
	# unzip install files
	#
	################################
	
	log "------DST Unzip the IHS zip file 1-----" do
	   level :info
	end

	execute "Unzip IHS File 1" do
	  user "root"
	  cwd node['ihs8004']['config']['mount']
	  command "unzip -o #{node['ihs8004']['zip']['file1']} -d #{node['ihs8004']['config']['cache']}"
	  action :run
	end

	log "------DST Unzip the IHS zip file 2-----" do
	   level :info
	end

	execute "Unzip IHS File 2" do
	  user "root"
	  cwd node['ihs8004']['config']['mount']
	  command "unzip -o #{node['ihs8004']['zip']['file2']} -d #{node['ihs8004']['config']['cache']}"
	  action :run
	end
	
	######################################
	#
	# Create a reponse file
	#
	######################################
	log "------DST Create a reponse file-----" do 
	   level :info
	end
	
	template "#{node['ihs8004']['config']['cache']}/#{node['ihs8004']['response']['file']}" do
	source "#{node['ihs8004']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	variables({ :cache_path => node['ihs8004']['config']['cache']}) 
	action :create_if_missing
	end

	
	####################################
	#
	# install IHS FP0000001
	#
	####################################
	log "------DST install ihs FP0000001-----" do
	  level :info
	end

	execute "Install IHS FP0000001" do
	 cwd node['im']['base']
	 command "./imcl -acceptLicense -input #{node['ihs8004']['config']['cache']}/#{node['ihs8004']['response']['file']} -log #{node['ihs8004']['log']['file']}"
	 action :run
	end

	#######################################
	#
	# Start IHS 
	#
	#######################################

	log "------DST Start IHS----- " do 
	  level :info
	end

	execute "Start IHS Server" do
	  user "root"
	  cwd node['ihs8004']['base']['path']
	  command "#{node['ihs8004']['base']['path']}/bin/apachectl start"
	  action :run
	end


	####################################################################
	#
	# Add Http start in initab
	#
	#####################################################################

	log "-------------DST Add http start in inittab -----------" 
	
	if (!(File.readlines("/etc/rc.local").grep(/apachectl start/).any?))
	  execute "Add http start in rc.local" do
	    user "root"
	    cwd node['ihs8000']['base']['path']
	    command "echo /opt/IBM/HTTPServer/bin/apachectl start >> /etc/rc.local"
	    action :run
	  end
	end

	#######################################
	#
	# Delete unzip file
	#
	########################################
	log "------DST remove cache directory-----" do
	 level :info
	end
	directory node['ihs8004']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   
 