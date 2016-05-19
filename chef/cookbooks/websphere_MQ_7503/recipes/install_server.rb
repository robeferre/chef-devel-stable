class Chef::Recipe
  include Helper_mq7503
end
if package_already_installed == false
	include_recipe "ibm_network_handler"
	case node['platform_family']
	when 'rhel'
	  include_recipe 'websphere_MQ_7503::mq7503_rhel_server'
	when 'aix'
	  include_recipe 'websphere_MQ_7503::mq7503_aix_server'
	when 'windows'
	  include_recipe 'websphere_MQ_7503::mq7503_windows_server'
	end
else 
   log "--- MQSeries is already install ---"

end