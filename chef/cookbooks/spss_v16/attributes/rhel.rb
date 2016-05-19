case node['platform_family']
when 'rhel'
  default['spss']['srv_file']             = "spss_mod_svr_16.0_linux_ml.bin"
  default['spss']['batch_file']           = "spss_mod_Btch_16.0_linux_ml.bin"
  default['spss']['url_srv']              = "/install/CHEF_FILES/DSTSA/SPSS16/LINUX/spss_mod_svr_16.0_linux_ml.bin"
  default['spss']['url_batch']            = "/install/CHEF_FILES/DSTSA/SPSS16/LINUX/spss_mod_Btch_16.0_linux_ml.bin"
  default['spss']['version']              = '16.0'
  default['spss']['cache']                = Chef::Config[:file_cache_path] + "/spss_install"
  default['spss']['srv_response']         = "#{node['spss']['cache']}spss_srv_installer.properties"
  default['spss']['batch_response']       = "#{node['spss']['cache']}spss_batch_installer.properties"
  default['spss']['base_install']         = "/usr/IBM/SPSS/ModelerServer/16.0"
end