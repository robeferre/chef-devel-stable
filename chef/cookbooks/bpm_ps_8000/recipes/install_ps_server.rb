include_recipe 'im::install'
if (!(File.exists?(node['bpm8000']['base']['path'])&& File.directory?(node['bpm8000']['base']['path'])))

	include_recipe "ibm_network_handler"

	case node['platform_family']
	when 'rhel'
 
	when 'aix'
  
	when 'windows'
  	  include_recipe 'bpm_ps_8000::wasND_8003_windows'
       include_recipe 'bpm_ps_8000::bpm_8000_windows'
       include_recipe 'bpm_ps_8000::dbExpress_9704_windows'
      end
else
	log "--- the folder #{node['bpm8000']['base']['path']} already exist" do 
	level :info
	end
end