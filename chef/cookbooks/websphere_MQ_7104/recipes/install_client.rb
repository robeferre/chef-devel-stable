class Chef::Recipe
  include Helper_mq7104
end

if package_already_installed == false

	log "---DST CHEF script for webphsere MQ Client v7.1.0.4---"
	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
	  include_recipe 'websphere_MQ_7104::mq7104_rhel_client'
	when 'aix'
	  include_recipe 'websphere_MQ_7104::mq7104_aix_client'
	when 'windows'
	  include_recipe 'websphere_MQ_7104::mq7104_windows_client'
	end
else 
   log "--- MQSeries is already install ---"

end