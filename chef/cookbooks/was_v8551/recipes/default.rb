##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
##########################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

class Chef::Recipe
  include Helper_was8551
end

if package_already_installed == false
    
  include_recipe 'was_v85::default'
  include_recipe 'ibm_network_handler'
  
  platform_family = node['platform_family']
  
  if platform_family == "rhel"
  	include_recipe 'was_v8551::was8551_rhel'
  elsif platform_family == "windows"
  	include_recipe 'was_v8551::was8551_windows'
  elsif platform_family == "aix"
  	include_recipe 'was_v8551::was8551_aix'
  end

end