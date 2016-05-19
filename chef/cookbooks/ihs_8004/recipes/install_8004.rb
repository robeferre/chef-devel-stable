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
class Chef::Recipe
  include Helper_ihs8004
end

if package_already_installed == false
	
	log "---DST start install HTTP Server v8.0.0.4----"

	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
	  include_recipe 'ihs_8004::_ihs_rhel_8004'
	when 'aix'
	  include_recipe 'ihs_8004::_ihs_aix_8004'
	end
else 
 log "--- HTTPServer folder exist (HTTP Server 8.0.0.4 or more version is already install) ---"
end