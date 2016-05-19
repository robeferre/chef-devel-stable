

class Chef::Recipe
  include Helper_was_nd_8007
end

if package_already_installed == true

	include_recipe "was_nd_80::install_80"

	log "---DST start installation ----"

	include_recipe "ibm_network_handler"

	case node['platform_family']
	 when 'rhel'
	  include_recipe 'was_nd_8007::was_nd_8007_rhel'
	 when 'windows'
	  include_recipe 'was_nd_8007::was_nd_8007_windows'
	end
else 
	log "--- Websphere Application Server ND 8007 is already installed ---" 
end
