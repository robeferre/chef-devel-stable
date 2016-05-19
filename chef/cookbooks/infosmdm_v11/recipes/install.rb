log "DST Chef Cookbook to deploy IBM InfoSphere MDM v11"

include_recipe 'was_v8552::install'
#include_recipe 'websphere_MQ_7503::mq7503_rhel_server'
include_recipe 'im_173::rhel_update'
include_recipe 'db2_ese_v105::server_install'
include_recipe 'ibm_network_handler'

case node['platform_family']
	when 'rhel'
	 	include_recipe 'infosmdm_v11::rhel_install'
	#when 'aix'
	#  include_recipe 'infosmdm_v11::aix_install'
	#when 'windows'
	#  include_recipe 'infosdmd_v11::window_install'
end