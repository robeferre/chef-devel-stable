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
  include Helper_was_85
end

if package_already_installed == false
  
  # IBM Network Handler test
  include_recipe 'ibm_network_handler'
  include_recipe 'im::install'

  platform_family = node['platform_family']
  
  if platform_family == "rhel"
  	include_recipe 'was_v85::was85_rhel'
  elsif platform_family == "aix"
    include_recipe 'was_v85::was85_aix'
  elsif platform_family == "windows"
  	include_recipe 'was_v85::was85_windows'
  end 


end
