class Chef::Recipe
  include Helper_mq7503
end

if package_already_installed == false

	log "---DST CHEF script for webphsere MQ Client v7.5.0.3---"
	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
	  include_recipe 'websphere_MQ_7503::mq7503_rhel_client'
	when 'aix'
	  include_recipe 'websphere_MQ_7503::mq7503_aix_client'
	when 'windows'
	  include_recipe 'websphere_MQ_7503::mq7503_windows_client'
	end
else 
   log "--- MQSeries is already install ---"

end