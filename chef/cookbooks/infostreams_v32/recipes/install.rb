log "DST Chef Cookbook to deploy IBM InfoSphere Streams v3.2"

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'infostreams_v32::rhel_install'
#when 'aix'
#  include_recipe 'spss_v16::aix_install'
#when 'windows'
#  include_recipe 'spss_v16::window_install'
end