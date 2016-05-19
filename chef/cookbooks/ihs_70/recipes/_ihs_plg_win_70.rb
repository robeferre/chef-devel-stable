#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# Update Installer for IHS Server (HTTP SERVER)
#
#################################################################
plg_cache_path	= "#{node['ihs70']['config']['cache']}/plugin"

if (!(File.directory?(node['ihs70']['plg']['path'])))


		log "---DST Create the directory cache path #{node['ihs70']['config']['mount']}---" do
   	  level :info
	end
 
	directory node['ihs70']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end 


	######################################
	#
	# Create a reponse file
	#
	######################################
	log "-------------DST Create a reponse file-----------" do 
	   level :info
	end
	
	template "#{node['ihs70']['config']['mount']}/#{node['ihs70']['plg']['respfile']}" do
	source "#{node['ihs70']['plg']['erb']}"
	rights :full_control,'Administrator'
	variables({ :ihs_plg_location => node['ihs70']['plg']['path']})
	action :create_if_missing
	end

	####################################
	#
	# install websphere plugins silently
	#
	####################################
	log "-----DST install websphere plugin silently------" do
	  level :info
	end

	execute "Install websphere plugin" do
	 cwd plg_cache_path
	 command "#{plg_cache_path}\\install.exe -options #{node['ihs70']['config']['mount']}\\#{node['ihs70']['plg']['respfile']} -silent"
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
	  rights :full_control,'Administrator'
	  recursive true
	  action :delete
	end   


else

  log "The Websphere Plugins is already install!" do
  level :info
  end

end



