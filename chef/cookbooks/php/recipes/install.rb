# Getting the best server and generating the dynamics source urls
include_recipe "ibm_network_handler"
log "The Best server is: #{$BEST_SERVER}"

# OS switch
log "DST CHEF script for PHP v5.5.10"

case node['platform_family']
when 'rhel'
  include_recipe 'php::rhel_install'
when 'aix'
  include_recipe 'php::aix_install'
end