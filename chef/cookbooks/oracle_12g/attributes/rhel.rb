case node['platform_family']
when 'rhel'
  default['oracle']['rhel']['package1_file']      = "linuxamd64_12c_database_1of2.zip"
  default['oracle']['rhel']['package2_file']      = "linuxamd64_12c_database_2of2.zip"
  default['oracle']['rhel']['url_pkg1']           = "/install/CHEF_FILES/ORACLE/12G/RHEL/linuxamd64_12c_database_1of2.zip"
  default['oracle']['rhel']['url_pkg2']           = "/install/CHEF_FILES/ORACLE/12G/RHEL/linuxamd64_12c_database_2of2.zip"
  default['oracle']['rhel']['version']            = '12g'
  default['oracle']['rhel']['setup']              = 'runInstaller' 
  default['oracle']['rhel']['cache']              = Chef::Config[:file_cache_path] + "/oracle_install"
  default['oracle']['rhel']['rsp_file']           = "#{node['oracle']['rhel']['tmp_dir']}/rhel_oracle11g.rsp"
  default['oracle']['rhel']['tmp_install']        = "#{node['oracle']['rhel']['cache']}/database"
  default['oracle']['rhel']['groups']             = ["dba", "oper", "oinstall"]
  default['oracle']['rhel']['inventorydir']       = "/opt/app"
  default['oracle']['rhel']['install_log']        = "#{node['oracle']['rhel']['cache']}/silent_install.log"
  
  
  
  default['oracle']['rhel']['appdir']             = "/opt/app"
  default['oracle']['rhel']['basedir']            = "/opt/app/oracle"

  default['oracle']['rhel']['product_dir']        = "/opt/app/oracle/product/#{node['oracle']['rhel']['version']}/dbhome_1"
  default['oracle']['rhel']['bin_dir']            = "#{node['oracle']['rhel']['product_dir']}/bin"
end