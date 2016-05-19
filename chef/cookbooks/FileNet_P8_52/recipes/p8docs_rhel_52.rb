###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM FileNet P8 5.2 documentation
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['p8docs']['zip']['location']}"


if (!(File.directory?(node['p8docs']['base_install'])))


#############################
#
# create Cache_path for P8 doc
#
#############################

log "-------------DST Create the directory cache path #{node['p8docs']['config']['mount']}-----------"
 
	directory node['p8docs']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "-------------DST Create the directory cache path #{node['p8docs']['config']['cache']}-----------"

	directory node['p8docs']['config']['cache'] do
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

	remote_file "#{node['p8docs']['config']['mount']}/#{node['p8docs']['zip']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	log "-----------DST Unzip the WCM zip file 1--------" 

	execute "Unzip Content Manager File 1" do
	  user "root"
	  cwd node['p8docs']['config']['mount']
	  command "unzip -o #{node['p8docs']['zip']['file']} -d #{node['p8docs']['config']['cache']}"
	  action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['p8docs']['config']['mount']}/#{node['p8docs']['response']['file']}" do
	source "#{node['p8docs']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0600'
	action :touch
	end

    # Changing permissions from the tar.gz file to 0777
    execute "Changing permissions from #{node['p8docs']['install']['file']}" do
    user "root"
    cwd node['p8docs']['installfile']['path']
    command "chmod 0777 #{node['p8docs']['install']['file']}"
    action :run
    end

	####################################
	#
	# install FileNet P8 documentation silently
	#
	####################################
	log "-----DST install Filenet documentation silently------"

	execute "Install P8docs" do
	 cwd node['p8docs']['installfile']['path']
	 command "./#{node['p8docs']['install']['file']} -i silent -f #{node['p8docs']['config']['mount']}/#{node['p8docs']['response']['file']}"
	 action :run
	end

	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['p8docs']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "FileNet documentation is already installed on this machine." do
  level :info
  end
end

