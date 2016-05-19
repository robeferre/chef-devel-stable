Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

include_recipe 'ibm_network_handler'

case node['platform_family']
when 'rhel'
  include_recipe 'im_173::rhel_install'
end