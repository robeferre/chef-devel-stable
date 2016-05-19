log "Oracle 11g Cookbook Install"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'oracle_11g::client_linux'
# when 'aix'
  # include_recipe 'oracle_11g::server_aix'
when 'windows'
  include_recipe 'oracle_11g::client_windows'
end