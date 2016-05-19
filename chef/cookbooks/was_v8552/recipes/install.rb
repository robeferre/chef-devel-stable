##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Daniel Abraao Silva Costa
# Contact: dasc@br.ibm.com
#
##########################################################################################################

# class Chef::Recipe
#   include InstallationCheck
# end

CheckedList = checkInstalledPackages()

if (CheckedList == false)
  include_recipe 'ibm_network_handler'
  include_recipe 'was_v85::default'

  case node['platform_family']
    # when 'aix'
    #   include_recipe 'was_v8552::aix_install'
    when 'rhel'
      include_recipe 'was_v8552::rhel_install'
    # when 'windows'
    #   include_recipe 'was_v8552::win_install'
  end
end