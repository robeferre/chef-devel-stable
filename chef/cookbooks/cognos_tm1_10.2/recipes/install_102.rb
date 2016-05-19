########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################

log "DST CHEF script for Cognos TM1 v10.2"

include_recipe "ibm_network_handler"
include_recipe 'ihs_8550::install_8550'
include_recipe 'ihs_8551::install_8551'
include_recipe 'db2_ese_v10::client_install'

#############################
#
# Check the platform used
#
#############################

case node['platform_family']
when 'rhel'
  include_recipe 'cognos_tm1_10.2::cognos_tm1_rhel_102'
when 'aix'
when 'windows'
end
