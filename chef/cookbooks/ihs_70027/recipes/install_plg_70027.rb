########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
########################################################################################################################
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# IHS Server (HTTP SERVER)
#
########################################################################################################################


#############################
#
# Check the platform used
#
#############################

#class Chef::Recipe
#  include Helper_plg70027
#end

#if package_already_installed == true


	log "---DST CHEF script for webSphere Plugins for HTTP Server v7.0.0.27---"

	include_recipe "ibm_network_handler"
	case node['platform_family']
	when 'rhel'
	  include_recipe 'ihs_70027::_plg_rhel_70027'
	when 'windows'
	  include_recipe 'ihs_70027::_plg_win_70027'
	end

#else 
# log "--- Websphere Plugins already exist (HTTP Server/Plugins 7.0.0.27 is already install) ---"
#end


