log "DST CHEF script for DB2 JDBC Connectors v9.7"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'db2_ese_v97::db2jdbc_rhel_install'
when 'aix'
  include_recipe 'db2_ese_v97::db2jdbc_aix_install'
when 'windows'
  include_recipe 'db2_ese_v97::db2jdbc_window_install'
end