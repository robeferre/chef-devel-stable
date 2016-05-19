########################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################

log "DST CHEF script for Cognos BI v10.2.1"

include_recipe "ibm_network_handler"
include_recipe 'im_173::install'
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
  include_recipe 'cognos_bi_10.2.1::cognos_bi_rhel_1021'
  include_recipe 'cognos_bi_10.2.1::cognos_bi_smps_rhel_1021'
  include_recipe 'cognos_bi_10.2.1::cognos_bi_dmgr_rhel_1021'
  include_recipe 'cognos_bi_10.2.1::cognos_bi_ihs_setup'
  include_recipe 'cognos_bi_10.2.1::cognos_bi_netezza_setup'
when 'aix'
when 'windows'
end
