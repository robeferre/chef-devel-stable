log "IBM WorkLight Enterprise Edition v6.2"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'wee_v62::rhel_install_db2_version'
# when 'aix'
  # include_recipe 'wee_v62::aix_install'
# when 'windows'
  # include_recipe 'wee_v62::window_install'
end