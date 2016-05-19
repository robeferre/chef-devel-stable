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
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['ihs70']['zip']['location1']}"
ihs_cache_path	= "#{node['ihs70']['config']['cache']}/IHS"

#############################
#
# create Cache_path for IHS
#
#############################

# Testing if the IHS is already installed
if (!(File.exists?(node['ihs70']['base']['path']) && File.directory?(node['ihs70']['base']['path'])))

	log "---DST Create the directory cache path #{node['ihs70']['config']['mount']}---" do
   	  level :info
	end
 
	directory node['ihs70']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

	log "---DST Create the directory cache path #{node['ihs70']['config']['cache']}----" do
		level :info
	end

	directory node['ihs70']['config']['cache'] do
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
	log "-------------DST Get the WAS zip 1 file-----------" do
	level :info
	end

	remote_file "#{node['ihs70']['config']['mount']}/#{node['ihs70']['zip']['file']}" do
	source ihs_dynamic_url_file1
	action :create_if_missing
	end
	

	################################
	#
	# untar install files
	#
	################################
	


	log "----DST - Unzip the IHS Server gzip file ----"
	
	execute "extract Gzip ihs file.tar.gz " do
	  user "root"
	  cwd node['ihs70']['config']['mount']
	  command " gzip -d #{node['ihs70']['zip']['file']}"
	  action :run
	end


	log "-----DST Untar the IHS zip file 1-----" do
	   level :info
	end

	execute "Untar IHS" do
    	   user "root"
    	   cwd node['ihs70']['config']['mount']
    	   command "tar -xf #{node['ihs70']['tar']['file']} -C #{node['ihs70']['config']['cache']}"
   	   action :run
	end



	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" do 
	   level :info
	end
	
	template "#{node['ihs70']['config']['mount']}/#{node['ihs70']['response']['file']}" do
	source "#{node['ihs70']['response']['erb']}"
	owner  'root'
	group  'root'
	mode   '0755'
	variables({ :ihs_location => node['ihs70']['base']['path'],
		:ipnode => node[:fqdn]})
	action :create_if_missing
	end

	####################################
	#
	# install IHS silently
	#
	####################################
	log "-------------DST install ihs silently-----------" do
	  level :info
	end

	execute "Install IHS" do
	 cwd ihs_cache_path
	 command "/DST/ihs_70_base_install/unzip/IHS/install -options #{node['ihs70']['config']['mount']}/#{node['ihs70']['response']['file']} -silent"
	 action :run
	end

	
	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------" do
	 level :info
	end
	directory node['ihs70']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   


else

  log "IBM HTTP Server already installed!" do
  level :info
  end

end



