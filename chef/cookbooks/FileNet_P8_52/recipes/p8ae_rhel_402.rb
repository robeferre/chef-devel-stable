###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM FileNet P8 5.2 Application Engine
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['p8ae']['zip']['location']}"

if (!(File.directory?(node['p8ae']['base_install'])))

#############################
#
# create Cache_path for CPE
#
#############################

log "-------------DST Create the directory cache path #{node['p8ae']['config']['mount']}-----------"
 
	directory node['p8ae']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "-------------DST Create the directory cache path #{node['p8ae']['config']['cache']}-----------"

	directory node['p8ae']['config']['cache'] do
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
log "------DST Get the Application Engine zip file----" 

	remote_file "#{node['p8ae']['config']['mount']}/#{node['p8ae']['zip']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	
	log "--DST - Unzip the Content Platform Engine gzip file --"
	
	execute "extract Gzip cpe file.tar.gz " do
	  user "root"
	  cwd node['p8ae']['config']['mount']
	  command " gzip -d #{node['p8ae']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the CPE zip file 1-----" do
	   level :info
	end

	execute "Untar cpe" do
    	   user "root"
    	   cwd node['p8ae']['config']['cache']
    	   command "tar -xvf #{node['p8ae']['config']['mount']}/#{node['p8ae']['tar']['file']}"
   	   action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['p8ae']['config']['mount']}/#{node['p8ae']['response']['file']}" do
	source "#{node['p8ae']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	variables({
      :localhost => node['fqdn']
    })
	action :touch
	end


	####################################
	#
	# install FileNet P8 documentation silently
	#
	####################################
	log "-----DST install Content Platform Engine silently---"

	execute "Install P8AE" do
	 cwd node['p8ae']['config']['cache']
	 command "./#{node['p8ae']['install']['file']} -options #{node['p8ae']['config']['mount']}/#{node['p8ae']['response']['file']} -silent"
	 action :run
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['p8ae']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "FileNet Application Engine is already installed on this machine." do
  level :info
  end
end

