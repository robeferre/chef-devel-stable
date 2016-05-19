log "DST CHEF script for DB2 v10"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'db2_ese_v10::rhel_server_install'
when 'aix'
  include_recipe 'db2_ese_v10::aix_server_install'
when 'windows'
  include_recipe 'db2_ese_v10::window_server_install'
end