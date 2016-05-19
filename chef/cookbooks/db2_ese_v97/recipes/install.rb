log "DST CHEF script for DB2 v97"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'db2_ese_v97::rhel_install'
when 'aix'
  include_recipe 'db2_ese_v97::aix_install'
when 'windows'
  #include_recipe 'db2_ese_v97::window_install'
end