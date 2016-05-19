##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

class Chef::Recipe
  include Helper_was_70
end

if package_already_installed == false
  
  Chef::Log.info('--- DST start installation ----')
  
  # IBM Network Handler test
  include_recipe 'ibm_network_handler'
  
  platform_family = node['platform_family']
  if platform_family == "rhel"
  	include_recipe 'was_nd_70027::was70_rhel'
  elsif platform_family == "windows"
  	include_recipe 'was_nd_70027::was70_windows'
  end 

end
