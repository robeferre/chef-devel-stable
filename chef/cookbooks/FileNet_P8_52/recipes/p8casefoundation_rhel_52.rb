###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM FileNet P8 5.2 Case foundation
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['p8casefound']['zip']['location']}"

if (!(File.directory?(node['p8casefound']['base_install'])))

#############################
#
# create Cache_path for Case Foundation
#
#############################

log "-------------DST Create the directory cache path #{node['p8casefound']['config']['mount']}-----------"
 
	directory node['p8casefound']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "-------------DST Create the directory cache path #{node['p8casefound']['config']['cache']}-----------"

	directory node['p8casefound']['config']['cache'] do
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
log "------DST Get the Content Platform Engine zip file----" 

	remote_file "#{node['p8casefound']['config']['mount']}/#{node['p8casefound']['zip']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	
	log "--DST - Unzip the Case Foundation gzip file --"
	
	execute "extract Gzip cpe file.tar.gz " do
	  user "root"
	  cwd node['p8casefound']['config']['mount']
	  command " gzip -d #{node['p8casefound']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the Case Foundation zip file 1-----" do
	   level :info
	end

	execute "Untar cpe" do
    	   user "root"
    	   cwd node['p8casefound']['config']['cache']
    	   command "tar -xvf #{node['p8casefound']['config']['mount']}/#{node['p8casefound']['tar']['file']}"
   	   action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['p8casefound']['config']['mount']}/#{node['p8casefound']['response']['file']}" do
	source "#{node['p8casefound']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	action :touch
	end


	####################################
	#
	# install FileNet P8 Case Foundation silently
	#
	####################################
	log "-----DST install Case Foundation silently---"

	execute "Install P8CaseFoundation" do
	 cwd node['p8casefound']['config']['cache']
	 command "./#{node['p8casefound']['install']['file']} -i silent -f #{node['p8casefound']['config']['mount']}/#{node['p8casefound']['response']['file']}"
	 action :run
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['p8casefound']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "FileNet Case Foundation is already installed on this machine." do
  level :info
  end
end

