class Chef::Recipe
  include Helper_bpm_8012
end

if package_already_installed == false

	log "---DST start installation ----"

	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
	 
	when 'aix'
	  
	when 'windows'
	  include_recipe 'bpm_ps_8012::bpm_8012_windows'
	end
else 
 log "--- Business Process Manager 8.0.1.2 : Process server is already installed ---"
end