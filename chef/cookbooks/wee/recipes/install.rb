log "DST CHEF script for WorkLight Enterprise Edition v1.0"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'wee::rhel_install'
when 'aix'
  include_recipe 'wee::aix_install'
when 'windows'
  include_recipe 'wee::window_install'
end