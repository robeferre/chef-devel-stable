log "DST CHEF script for webphsere MQ Server v7.1.0.3"

include_recipe "ibm_network_handler"

case node['platform_family']
when 'rhel'
  include_recipe 'websphere_MQ_7103::mq7103_rhel_server'
when 'aix'
  include_recipe 'websphere_MQ_7103::mq7103_aix_server'
when 'windows'
  include_recipe 'websphere_MQ_7103::mq7103_windows_server'
end