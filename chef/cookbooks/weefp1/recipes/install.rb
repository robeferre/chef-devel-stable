log "Upgrade IBM Worklight Enterprise Edition 6 to 6.1"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'weefp1::rhel_install'
when 'aix'
  include_recipe 'weefp1::aix_install'
when 'windows'
  include_recipe 'weefp1::window_install'
end