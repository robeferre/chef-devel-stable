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

log "DST CHEF script for IBM WebSphere SDK Java v7.0"

class Chef::Recipe
  include Helper_sdk70
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
  		include_recipe 'websphereSDKjava_70::_sdk_rhel_70'
	end

else 
 log "--- WebSphere SDK java 7.0 is already install ---"
end