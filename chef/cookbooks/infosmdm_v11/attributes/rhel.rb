case node['platform_family']
when 'rhel'
  default['infosmdm']['pkg_file1']    = "MDM_STD_ADV_11.4_ML_1.zip"
  default['infosmdm']['pkg_file2']    = "MDM_STD_ADV_11.4_ML_2.zip"
  default['infosmdm']['pkg_file3']    = "MDM_STD_ADV_11.4_ML_3.zip"
  default['infosmdm']['pkg_file4']    = "MDM_STD_ADV_11.4_ML_4.zip"
  default['infosmdm']['pkg_file5']    = "MDM_STD_ADV_11.4_ML_5.zip"
  default['infosmdm']['pkg_file6']    = "MDM_STD_ADV_11.4_ML_6.zip"
  default['infosmdm']['pkg1_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_1.zip"
  default['infosmdm']['pkg2_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_2.zip"
  default['infosmdm']['pkg3_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_3.zip"
  default['infosmdm']['pkg4_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_4.zip"
  default['infosmdm']['pkg5_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_5.zip"
  default['infosmdm']['pkg6_url']     = "/install/CHEF_FILES/DSTSA/MDM114/MDM_STD_ADV_11.4_ML_6.zip"
  default['infosmdm']['version']      = '11.4'
  default['infosmdm']['cache']        = Chef::Config[:file_cache_path] + "/mdm_install"
  default['infosmdm']['base_install'] = "/opt/IBM/MDM"

  default['infosmdm']['startup_kit']['pkg_file']        = "INS_TK_MDM_11.3_ML.zip"
  default['infosmdm']['startup_kit']['pkg_url']         = "/install/CHEF_FILES/DSTSA/MDM114/INS_TK_MDM_11.3_ML.zip"
  default['infosmdm']['startup_kit']['im_cache_path']   = "/DST/mdm_startupkit"

  default['infosmdm']['im_tools_path']   = "/opt/IBM/InstallationManager/eclipse/tools"
  default['infosmdm']['im_cache_path']   = "/DST/mdm_v114"

  default['infosmdm']['was_bin_path']    = "/opt/IBM/WebSphere/AppServer/bin"
  default['infosmdm']['was_dmgr01_path']  = "/opt/IBM/WebSphere/AppServer/profiles/Dmgr01"
  default['infosmdm']['was_node02_path']  = "/opt/IBM/WebSphere/AppServer/profiles/Node02"
  default['infosmdm']['was_profile_usr'] = "mdmadmin"
  default['infosmdm']['was_profile_pw']  = "dst4you"

  default['infosmdm']['db2_user']        = "db2inst1"
  default['infosmdm']['db2_pass']        = "db2inst1"
  default['infosmdm']['db2_home']        = "/home/db2inst1/"
  default['infosmdm']['mdm_database']    = "MDM11DB"
end