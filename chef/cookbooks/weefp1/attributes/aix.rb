case node['platform_family']
when 'aix'
  default['weefp1']['url'] = '/install/CHEF_FILES/WEE/FP1/CIQ5NEN.zip'
  default['weefp1']['file'] = "CIQ5NEN.zip"
  default['weefp1']['cache'] = Chef::Config[:file_cache_path] + "/weefp1_install"
  
  default['weefp1']['ibm_install_dir'] = "/opt/IBM/"
  default['weefp1']['wl_cache'] = "#{node['weefp1']['cache']}/"
  default['weefp1']['wl_disk'] = "#{node['weefp1']['cache']}/Worklight/disk1"
  default['weefp1']['wl_install_dir'] = "/opt/IBM/Worklight/"
  
  default['weefp1']['im_shared_dir'] = "/DST/wee6fp1/"
  default['weefp1']['wl_disk'] = "#{node['weefp1']['im_shared_dir']}/Worklight/disk1"
end