###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# Update Installer for IHS Server (HTTP SERVER)
#
#################################################################################################################################
updateinst_cache_path	= "#{node['ihs70027']['updateinst']['cache']}/UpdateInstaller"

log "---DST updqteinst directory cache path #{node['ihs70027']['updateinst']['path']}---" do
   	  level :info
	end
 
if (!(File.exists?(node['ihs70027']['updateinst']['path']) && File.directory?(node['ihs70027']['updateinst']['path'])))


		log "---DST Create the directory cache path #{node['ihs70027']['config']['mount']}---" do
   	  level :info
	end
 
	directory node['ihs70027']['config']['mount'] do
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
	
	template "#{node['ihs70027']['config']['mount']}/#{node['ihs70027']['updateinst']['respfile']}" do
	source "#{node['ihs70027']['updateinst']['erb']}"
	  rights :full_control,'Administrator'
	  variables({	:ihs_update_location => node['ihs70027']['updateinst']['path']})
	  action :create_if_missing
	end

	####################################
	#
	# install UpdateInstaller silently
	#
	####################################
	log "-----DST install updateInstaller silently------" do
	  level :info
	end

	execute "Install IHS" do
	 cwd updateinst_cache_path
	 command "#{updateinst_cache_path}/install.exe -options #{node['ihs70027']['config']['mount']}/#{node['ihs70027']['updateinst']['respfile']} -silent"
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
	directory node['ihs70027']['config']['mount'] do
	  rights :full_control,'Administrator'
	  recursive true
	  action :delete
	end   


else

  log "IBM UpdateInstaller is already installed!" do
  level :info
  end

end



