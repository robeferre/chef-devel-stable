###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM FileNet P8 5.2 Content Platform Engine Client
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['p8cpec']['zip']['location']}"


if (!(File.directory?(node['p8cpec']['base_install'])))

#############################
#
# create Cache_path for CPE
#
#############################

log "-------------DST Create the directory cache path #{node['p8cpec']['config']['mount']}-----------"
 
	directory node['p8cpec']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "-------------DST Create the directory cache path #{node['p8cpec']['config']['cache']}-----------"

	directory node['p8cpec']['config']['cache'] do
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
log "------DST Get the Content Platform Engine clt zip file----" 

	remote_file "#{node['p8cpec']['config']['mount']}/#{node['p8cpec']['zip']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	
	log "--DST-Unzip the Content Platform Engine clt gzip file --"
	
	execute "extract Gzip cpec file.tar.gz " do
	  user "root"
	  cwd node['p8cpec']['config']['mount']
	  command " gzip -d #{node['p8cpec']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the CPEC zip file 1-----" do
	   level :info
	end

	execute "Untar cpec" do
    	   user "root"
    	   cwd node['p8cpec']['config']['cache']
    	   command "tar -xvf #{node['p8cpec']['config']['mount']}/#{node['p8cpec']['tar']['file']}"
   	   action :run
	end

	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" 
	
	template "#{node['p8cpec']['config']['mount']}/#{node['p8cpec']['response']['file']}" do
	source "#{node['p8cpec']['response']['erb']}"
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
	log "---DST install Content Platform Engine clt silently---"

   bash "install_p8cpc" do
    returns [0, 1]    
    code <<-EOL
    /DST/p8cpec_52_base_install/unzip/5.2.0-P8CE-CLIENT-LINUX.BIN -i silent -f /tmp/chef-solo/p8cpec_52_base_install/ceclient_silent_install.txt
    EOL
  end

#	execute "Install P8CPEC" do
#	 cwd node['p8cpec']['config']['cache']
#	 command "./#{node['p8cpec']['install']['file']} -i silent -f #{node['p8cpec']['config']['mount']}/#{node['p8cpec']['response']['file']}"
#	 timeout 86400
#	 action :run
#	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['p8cpec']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "FileNet Content Platform Engine client is already installed on this machine." do
  level :info
  end
end

