###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################
#
# IHS Server (HTTP SERVER)
#
##########################################################

##########################################################
#
# install UpdateInstaller if needed
#
##########################################################
   
include_recipe 'ihs_70027::_updateInst_win_70'

################################################################
#
# Install IHS Server (HTTP SERVER)
#
##############################################################

ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['ihs70027']['fixpack27']['location']}"

ihs_fixpack_path = node['ihs70027']['config']['mount'] + "/" + node['ihs70027']['fixpack27']['file']


#############################
#
# create Cache_path for IHS
#
#############################


	log "Create the directory cache path #{node['ihs70027']['config']['mount']}" do
		level :info
	end
 
	directory node['ihs70027']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end  


	log "Create the directory cache path #{node['ihs70027']['config']['cache']}" do
		level :info
	end
 
	directory node['ihs70027']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  

	#############################
	#
	# copy /install in cache_path
	#
	#############################
	
	log "---Get the IHS FP27 file-----" do
	level :info
	end

	remote_file "#{node['ihs70027']['config']['mount']}/#{node['ihs70027']['fixpack27']['file']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end


	######################################
	#
	# Create a reponse file
	#
	######################################

	log "Create a reponse file" do 
	   level :info
	end
	
	template "#{node['ihs70027']['config']['cache']}/#{node['ihs70027']['response']['file']}" do
	source "#{node['ihs70027']['response']['erb']}"
	rights :full_control,'Administrator'
	variables(
	      :fixpack_path	  => "C:#{ihs_fixpack_path}",
	      :ihs_location    => node['ihs70027']['base']['path']
    )
	action :create_if_missing
	end

	
	####################################
	#
	# install IHS FP0000027
	#
	####################################

  
	execute "Aplly the fixpack27" do
	  cwd  node['ihs70027']['updateinst']['path']
	  command "update.bat -options C:\\DST\\ihs_70027_base_install\\unzip\\#{node['ihs70027']['response']['file']} -silent"
 	  action :run
	end



	#######################################
	#
	# Delete unzip file
	#
	########################################
	log "remove cache directory" do
	 level :info
	end
	directory node['ihs70027']['config']['mount'] do
	  rights :full_control,'Administrator'
	  recursive true
	  action :delete
	end   
