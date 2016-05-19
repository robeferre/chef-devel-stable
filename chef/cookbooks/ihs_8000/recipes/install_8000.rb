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

log "DST CHEF script for HTTP Server v8.0.0.0"

include_recipe "ibm_network_handler"

#############################
#
# Check the platform used
#
#############################

case node['platform_family']
when 'rhel'
  include_recipe 'ihs_8000::_ihs_rhel_8000'
when 'aix'
  include_recipe 'ihs_8000::_ihs_aix_8000'
end
