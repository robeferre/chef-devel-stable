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
  include Helper_ihs8502
end

include_recipe 'ihs_850::install_850'

if package_already_installed == false
	log "---DST CHEF script for HTTP Server v8.5.0.2---"

	include_recipe "ibm_network_handler"
	case node['platform_family']
	when 'rhel'
	  include_recipe 'ihs_8502::_ihs_rhel_8502'
	end
else 
 log "--- HTTPServer folder exist (HTTP Server 8.5.0.2 or another version is already install) ---"
end
