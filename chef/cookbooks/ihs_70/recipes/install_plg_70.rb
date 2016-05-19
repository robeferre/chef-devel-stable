########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
########################################################################################################################
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# IHS Server (HTTP SERVER)
#
########################################################################################################################
 log "DST CHEF script for websphere Plugins for HTTP Server v7.0"

#############################
#
# Check the platform used
#
#############################

case node['platform_family']
when 'rhel'
  include_recipe 'ihs_70::_ihs_plg_rhel_70'
when 'windows'
    include_recipe 'ihs_70::_ihs_plg_win_70'
end
