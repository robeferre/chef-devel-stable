class Chef::Recipe
  include Helper_mq7502
end
if package_already_installed == false
	log "DST CHEF script for webphsere MQ Server v7.5.0.2"
	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
	  include_recipe 'websphere_MQ_7502::mq7502_rhel_server'
	when 'aix'
	  include_recipe 'websphere_MQ_7502::mq7502_aix_server'
	when 'windows'
	  include_recipe 'websphere_MQ_7502::mq7502_windows_server'
	end
else 
   log "--- MQSeries is already install ---"

end