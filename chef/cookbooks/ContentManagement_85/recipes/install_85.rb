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
  include Helper_wcm85
end

if package_already_installed == false

	include_recipe "ibm_network_handler"
	include_recipe 'im_173::install'
	include_recipe 'was_v8551::default'
	include_recipe 'websphereSDKjava_70::install_70'
	include_recipe 'WebspherePortal_85::install_85'

	#############################
	#
	# Check the platform used
	#
	#############################

	case node['platform_family']
	when 'rhel'
  	   include_recipe 'ContentManagement_85::_wcm_rhel_85'
	end

	include_recipe 'ihs_8550::install_8550'
	include_recipe 'ihs_8551::install_8551'
	include_recipe 'db2_ese_v105::server_install'
else
 log "--- WebSphere Content Manager 8.5 is already install ---"
end
