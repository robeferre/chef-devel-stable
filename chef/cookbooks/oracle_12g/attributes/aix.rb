case node['platform_family']
when 'aix'
  default['oracle']['aix']['package1_file']      = "aix.ppc64_12c_database_1of2.zip"
  default['oracle']['aix']['package2_file']      = "aix.ppc64_12c_database_2of2.zip"
  default['oracle']['aix']['url_pkg1']           = "/install/CHEF_FILES/ORACLE/12G/AIX/aix.ppc64_12c_database_1of2.zip"
  default['oracle']['aix']['url_pkg2']           = "/install/CHEF_FILES/ORACLE/12G/AIX/aix.ppc64_12c_database_2of2.zip"
  default['oracle']['aix']['version']            = '12g'
  default['oracle']['aix']['setup']              = 'runInstaller' 
  default['oracle']['aix']['cache']            = Chef::Config[:file_cache_path] + "/oracle_install"
  default['oracle']['aix']['rsp_file']           = "#{node['oracle']['aix']['tmp_dir']}/rhel_oracle11g.rsp"
  default['oracle']['aix']['tmp_install']        = "#{node['oracle']['aix']['cache']}/database"
  default['oracle']['aix']['groups']             = ["dba", "oper", "oinstall"]
  default['oracle']['aix']['inventorydir']       = "/opt/app"
  default['oracle']['aix']['install_log']        = "#{node['oracle']['aix']['cache']}/silent_install.log"
  
  
  
  default['oracle']['aix']['appdir']             = "/opt/app"
  default['oracle']['aix']['basedir']            = "/opt/app/oracle"

  default['oracle']['aix']['product_dir']        = "/opt/app/oracle/product/#{node['oracle']['aix']['version']}/dbhome_1"
  default['oracle']['aix']['bin_dir']            = "#{node['oracle']['aix']['product_dir']}/bin"
end
