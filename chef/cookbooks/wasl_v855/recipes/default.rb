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
  include Helper_wasl_855
end

if package_already_installed == false
  
  platform_family = node['platform_family']
  include_recipe 'ibm_network_handler'
  include_recipe 'im::install'
  
  if platform_family == "rhel"
  	include_recipe 'wasl_v855::wasl_rhel'
  elsif platform_family == "aix"
  	include_recipe 'wasl_v855::wasl_aix'
  elsif platform_family == "windows"
  	include_recipe 'wasl_v855::wasl_windows'
  end

end



