case node['platform_family']
when 'aix'
  default['wee']['url'] = '/install/CHEF_FILES/WEE62/WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip'
  default['wee']['file'] = "WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip"
  default['wee']['cache'] = Chef::Config[:file_cache_path] + "/wee_install"
  
  default['wee']['ibm_install_dir'] = "/opt/IBM/"
  default['wee']['wl_cache'] = "#{node['wee']['cache']}/"
  default['wee']['wl_install_dir'] = "/opt/IBM/Worklight/"
  
  default['wee']['im_shared_dir'] = "/DST/wee62/"
  default['wee']['wl_disk'] = "#{node['wee']['im_shared_dir']}/Worklight/disk1"
end