Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'im::rhel_install'
when 'aix'
  include_recipe 'im::aix_install'
when 'windows'
  include_recipe 'im::windows_install'
end