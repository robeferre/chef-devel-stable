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

log "DST CHEF script for IBM Content Management v8.5"

class Chef::Recipe
  include Helper_wsp85
end

if package_already_installed == false

	include_recipe "ibm_network_handler"

	#############################
	#
	# Check the platform used
	#
	#############################

	case node['platform_family']
	when 'rhel'
	  include_recipe 'WebspherePortal_85::_wsp_rhel_85'
	end
else 
 log "--- WebSphere Portal 8.5 is already install ---"
end
