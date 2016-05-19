case node['platform_family']
when 'rhel'
  default['oracle']['rhel']['package1_file']      = "linux.x64_11gR2_database_1of2.zip"
  default['oracle']['rhel']['package2_file']      = "linux.x64_11gR2_database_2of2.zip"
  default['oracle']['rhel']['url_pkg1']           = "/install/CHEF_FILES/ORACLE/11G/RHEL/linux.x64_11gR2_database_1of2.zip"
  default['oracle']['rhel']['url_pkg2']           = "/install/CHEF_FILES/ORACLE/11G/RHEL/linux.x64_11gR2_database_2of2.zip"
  default['oracle']['rhel']['version']            = '11g'
  default['oracle']['rhel']['setup']              = 'runInstaller' 
  default['oracle']['rhel']['cache']            = Chef::Config[:file_cache_path] + "/oracle_install"
  default['oracle']['rhel']['rsp_file']           = "#{node['oracle']['rhel']['tmp_dir']}/rhel_oracle11g.rsp"
  default['oracle']['rhel']['tmp_install']        = "#{node['oracle']['rhel']['cache']}/database"
  default['oracle']['rhel']['groups']             = ["oinstall", "dba", "oper"]
  default['oracle']['rhel']['inventorydir']       = "/opt/app"
  default['oracle']['rhel']['install_log']        = "#{node['oracle']['rhel']['cache']}/silent_install.log"
  default['oracle']['rhel']['limits_conf']        = "/etc/security/limits.conf"
  
  
  default['oracle']['rhel']['appdir']             = "/opt/app"
  default['oracle']['rhel']['oradata']            = "/opt/app/oradata"
  
  default['oracle']['rhel']['basedir']            = "/opt/app/oracle"
  default['oracle']['rhel']['flash_recovery']     = "/opt/app/oracle/flash_recovery_area"
  
  default['oracle']['rhel']['home_folder']        = "/home/oracle"
  default['oracle']['rhel']['initd']              = "/etc/init.d"
  
  default['oracle']['rhel']['ora_root']            = "/opt/app/oracle/product/11.2.0/dbhome_3"

  default['oracle']['rhel']['product_dir']        = "/opt/app/oracle/product/#{node['oracle']['rhel']['version']}/dbhome_1"
  default['oracle']['rhel']['bin_dir']            = "#{node['oracle']['rhel']['product_dir']}/bin"
  
  default['oracle']['rhel']['tnsnames']            = "/opt/app/oracle/product/11.2.0/dbhome_3/network/admin/tnsnames.ora"
  
  default['oracle']['rhel']['client']['cache']   = Chef::Config[:file_cache_path] + "/oracle_client_install"  
  default['oracle']['rhel']['client']['package_file'] = "p13390677_112040_Linux-x86-64_4of7.zip"
  default['oracle']['rhel']['client']['pkg_url'] =  "/install/CHEF_FILES/ORACLE/11G/RHEL/CLIENT/p13390677_112040_Linux-x86-64_4of7.zip"
  default['oracle']['rhel']['client']['tmp_install'] = "#{node['oracle']['rhel']['client']['cache']}/client"
  default['oracle']['rhel']['client']['rsp_file'] = "#{node['oracle']['rhel']['client']['cache']}/win_oracle11g.rsp"
  default['oracle']['rhel']['client']['basedir']  = "/opt/app/oracle/client"
end
