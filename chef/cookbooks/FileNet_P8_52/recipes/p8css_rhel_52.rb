###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM FileNet P8 5.2 Content Search Services
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['p8css']['zip']['location']}"


if (!(File.directory?(node['p8css']['base_install'])))

#############################
#
# create Cache_path for CSS
#
#############################

log "-------------DST Create the directory cache path #{node['p8css']['config']['mount']}-----------"
 
	directory node['p8css']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "---DST Create the directory cache path #{node['p8css']['config']['cache']}---"

	directory node['p8css']['config']['cache'] do
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
log "------DST Get the Content Search Service zip file----" 

	remote_file "#{node['p8css']['config']['mount']}/#{node['p8css']['zip']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	
	log "--DST -Unzip the Content Search Service gzip file --"
	
	execute "extract Gzip CCS file.tar.gz " do
	  user "root"
	  cwd node['p8css']['config']['mount']
	  command " gzip -d #{node['p8css']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the CCS zip file 1-----" do
	   level :info
	end

	execute "Untar ccs" do
    	   user "root"
    	   cwd node['p8css']['config']['cache']
    	   command "tar -xvf #{node['p8css']['config']['mount']}/#{node['p8css']['tar']['file']}"
   	   action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['p8css']['config']['mount']}/#{node['p8css']['response']['file']}" do
	source "#{node['p8css']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	action :touch
	end


	####################################
	#
	# install FileNet P8 documentation silently
	#
	####################################
	log "-----DST install Content Search Service silently---"

	execute "Install P8CSS" do
	 cwd node['p8css']['config']['cache']
	 command "./#{node['p8css']['install']['file']} -i silent -f #{node['p8css']['config']['mount']}/#{node['p8css']['response']['file']}"
	 action :run
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['p8css']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end 
  
else
  log "FileNet Content Search Service is already installed on this machine." do
  level :info
  end
end


