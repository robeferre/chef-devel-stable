case node['platform_family']
when 'windows'
  default['oracle']['windows']['package1_file']      = "win64_11gR2_database_1of2.zip"
  default['oracle']['windows']['package2_file']      = "win64_11gR2_database_2of2.zip"
  default['oracle']['windows']['url_pkg1']           = "/install/CHEF_FILES/ORACLE/11G/WIN/win64_11gR2_database_1of2.zip"
  default['oracle']['windows']['url_pkg2']           = "/install/CHEF_FILES/ORACLE/11G/WIN/win64_11gR2_database_2of2.zip"
  default['oracle']['windows']['version']            = '11.2.0'
  default['oracle']['windows']['setup']              = 'setup.exe' 
  default['oracle']['windows']['cache']              = Chef::Config[:file_cache_path] + "\\oracle_install"
  default['oracle']['windows']['tmp_install']        = "#{node['oracle']['windows']['cache']}\\database"
  default['oracle']['windows']['rsp_file']           = "#{node['oracle']['windows']['cache']}\\win_oracle11g.rsp"
  
  default['oracle']['windows']['basedir']            = "#{ENV['SYSTEMDRIVE']}\\app\\oracle"
  default['oracle']['windows']['product_dir']        = "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\product\\#{node['oracle']['windows']['version']}\\dbhome_3"
  default['oracle']['windows']['bin_dir']            = "#{node['oracle']['windows']['product_dir']}\\BIN"
  
  default['oracle']['windows']['paths']            = { "ORACLE_HOSTNAME" => "#{node['hostname']}",
                                                         "ORACLE_UNQNAME" => "orcl",
                                                         "ORACLE_BASE" => "#{ENV['SYSTEMDRIVE']}\\app\\oracle",
                                                         "ORACLE_HOME" => "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\product\\11.2.0\\dbhome_3",
                                                         "ORACLE_SID" => "orcl" }

  default['oracle']['windows']['client']['cache']   = Chef::Config[:file_cache_path] + "\\oracle_client_install"  
  default['oracle']['windows']['client']['package_file'] = "p13390677_112040_MSWIN-x86-64_4of7.zip"
  default['oracle']['windows']['client']['pkg_url'] =  "/install/CHEF_FILES/ORACLE/11G/WIN/CLIENT/p13390677_112040_MSWIN-x86-64_4of7.zip"
  default['oracle']['windows']['client']['tmp_install'] = "#{node['oracle']['windows']['client']['cache']}\\client"
  default['oracle']['windows']['client']['rsp_file'] = "#{node['oracle']['windows']['client']['cache']}\\win_oracle11g.rsp"
  default['oracle']['windows']['client']['basedir']  = "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\client"
end
