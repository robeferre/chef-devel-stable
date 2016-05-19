case node['platform_family']
when 'windows'
  default['wee']['url'] = '/install/CHEF_FILES/WEE62/WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip'
  default['wee']['file'] = "WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip"
  default['wee']['cache'] = Chef::Config[:file_cache_path] + "/wee_install"
  
  default['wee']['wl_cache'] = "#{node['wee']['cache']}/Worklight/"
  default['wee']['wl_install_dir'] = "C:/Program Files/IBM/Worklight/"
  
  default['wee']['im_shared_dir'] = "C:/Program Files/IBM/IMShared"
end