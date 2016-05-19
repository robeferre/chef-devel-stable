case node['platform_family']
when 'rhel'
  default['wee62']['url'] = '/install/CHEF_FILES/WEE62/WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip'
  default['wee62']['file'] = "WKLT_ENT_ED_V6.2_ZIP_IMR_WKLT_Srv.zip"
  default['wee62']['cache'] = Chef::Config[:file_cache_path] + "/wee62_install"
  
  default['wee62']['ibm_install_dir'] = "/opt/IBM/"
  default['wee62']['wl_cache'] = "#{node['wee62']['cache']}/"
  default['wee62']['wl_disk'] = "#{node['wee62']['cache']}/Worklight/disk1"
  default['wee62']['wl_install_dir'] = "/opt/IBM/Worklight/"
  
  default['wee62']['im_shared_dir'] = "/DST/wee62/"
  default['wee62']['wl_disk'] = "#{node['wee62']['im_shared_dir']}/Worklight/disk1"
end