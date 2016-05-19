case node['platform_family']
when 'rhel'
  default['is']['is_file']            = "INFO_IS_11.3_LIN_86-64_ML.tar.gz"
  default['is']['img_file']           = "INFO_IS_11.3_BSF_ML.zip"
  default['is']['is_url']             = "/install/CHEF_FILES/DSTSA/INFOIS113/LINUX/INFO_IS_11.3_LIN_86-64_ML.tar.gz"
  default['is']['img_url']            = "/install/CHEF_FILES/DSTSA/INFOIS113/LINUX/INFO_IS_11.3_BSF_ML.zip"
  default['is']['version']            = '11.3'
  default['is']['cache']              = Chef::Config[:file_cache_path] + "/is_install"
  default['is']['installer_dir']      = Chef::Config[:file_cache_path] + "/is_install/is-suite/"
  default['is']['is_response']        = "#{node['is']['cache']}is_srv_installer.properties"
  default['is']['base_dir']           = "/opt/IBM/InformationServer"
  
  default['is']['users']              = {"db2inst1" => "ntSP296SKs7aA",
                                         "db2fenc1" => "25ZVGbH94JxRU",
                                         "xmeta"    => "PAbD.EDqatsF6",
                                         "xmetasr"  => "PAbD.EDqatsF6",
                                         "wasadmin" => "PAbD.EDqatsF6",
                                         "isadmin"  => "PAbD.EDqatsF6",
                                         "dsadm"    => "AxE3yZhXips1Y",
                                         "dsodb"    => "PAbD.EDqatsF6",
                                         "iauser"   => "PAbD.EDqatsF6",
                                         "srduser"  => "PAbD.EDqatsF6"}

 default['is']['groups']              = ['dstage']
 default['is']['limits_conf']         = "/etc/security/limits.conf"
end