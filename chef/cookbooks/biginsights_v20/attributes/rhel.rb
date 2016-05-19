################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'
  default['biginsights']['file']          = "BIGINSIGHT_ENTPR_ED_V2.0_LNX.tar.gz"
  default['biginsights']['url']           = "/install/CHEF_FILES/DSTSA/BIGINSIGHTS20/BIGINSIGHT_ENTPR_ED_V2.0_LNX.tar.gz"
  default['biginsights']['version']       = "2.0"
  default['biginsights']['cache']         =  Chef::Config[:file_cache_path] + "/bi_install"
  default['biginsights']['installer_dir'] =  Chef::Config[:file_cache_path] + "/bi_install/biginsights-enterprise-linux64_b20121203_1915"
  default['biginsights']['silent']        =  "#{node['biginsights']['installer_dir']}/silent-install"
  default['biginsights']['expect_path']   =  "#{node['biginsights']['installer_dir']}/artifacts"
  default['biginsights']['base_dir']      = "/opt/IBM/BigInsights"
  default['biginsights']['rsp_file']      = "#{node['biginsights']['cache']}/bi_install.rsp.xml"
end