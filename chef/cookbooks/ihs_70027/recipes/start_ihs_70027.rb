########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
########################################################################################################################
# Start IHS Server (HTTP SERVER)
#
##############################################################


#############################
#
# Check the platform used
#
#############################

	log "---DST CHEF script start HTTP Server v7.0.0.27---"

	case node['platform_family']
	when 'rhel'
	  include_recipe 'ihs_70027::_start_ihs_rhel_70027'
	when 'windows'
	  include_recipe 'ihs_70027::_start_ihs_win_70027'
	end


