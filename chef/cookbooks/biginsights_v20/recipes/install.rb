########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
########################################################################################################################
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# Infosphere BigInsghts V2.0
#
# Refactored by Daniel Costa (dasc@br.ibm.com)
#
########################################################################################################################

log "DST CHEF script for BigInsghts v2.0"
include_recipe "ibm_network_handler"

case node['platform_family']
when 'rhel'
  include_recipe 'biginsights_v20::rhel_install'
# when 'aix'
# when 'windows'
end
