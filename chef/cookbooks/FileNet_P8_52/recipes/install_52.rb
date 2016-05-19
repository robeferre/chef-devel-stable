########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
########################################################################################################################
# FileNet P8 5.2 
#
########################################################################################################################

log "DST CHEF script for install a distributed IBM FileNet P8 v5.2"


	include_recipe "ibm_network_handler"
	include_recipe 'im_173::install'
	include_recipe 'was_v8502::install'
	include_recipe 'websphereSDKjava_70::install_70'
	include_recipe 'ihs_8502::install_8502'
	include_recipe 'db2_ese_v10::server_install'
	
	#############################
	#
	# Check the platform used
	#
	#############################

	case node['platform_family']
	when 'rhel'
	   include_recipe 'FileNet_P8_52::rhel_db2_setup'
	   include_recipe 'FileNet_P8_52::tds_rhel_63_FP24'
  	   include_recipe 'FileNet_P8_52::p8docs_rhel_52'
	   include_recipe 'FileNet_P8_52::p8cpe_rhel_52'
	   include_recipe 'FileNet_P8_52::p8casefoundation_rhel_52'
	   include_recipe 'FileNet_P8_52::p8css_rhel_52'
	   include_recipe 'FileNet_P8_52::p8ae_rhel_402'
	   include_recipe 'FileNet_P8_52::p8cpec_rhel_52'
	end

	
