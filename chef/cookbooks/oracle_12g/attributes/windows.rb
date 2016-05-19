case node['platform_family']
when 'windows'
  default['oracle']['windows']['package1_file']      = "winx64_12c_database_1of2.zip"
  default['oracle']['windows']['package2_file']      = "winx64_12c_database_2of2.zip"
  default['oracle']['windows']['url_pkg1']           = "/install/CHEF_FILES/ORACLE/12G/WIN/winx64_12c_database_1of2.zip"
  default['oracle']['windows']['url_pkg2']           = "/install/CHEF_FILES/ORACLE/12G/WIN/winx64_12c_database_2of2.zip"
  default['oracle']['windows']['version']            = '12g'
  default['oracle']['windows']['setup']              = 'setup.exe' 
  default['oracle']['windows']['cache']              = Chef::Config[:file_cache_path] + "\\oracle_install"
  default['oracle']['windows']['rsp_file']           = "#{node['oracle']['windows']['tmp_dir']}\\win_oracle11g.rsp"
  default['oracle']['windows']['tmp_install']        = "#{node['oracle']['windows']['cache']}\\database"
  
  default['oracle']['windows']['basedir']            = "#{ENV['SYSTEMDRIVE']}\\app\\oracle"
  default['oracle']['windows']['product_dir']        = "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\product\\#{node['oracle']['windows']['version']}\\dbhome_1"
  default['oracle']['windows']['bin_dir']            = "#{node['oracle']['windows']['product_dir']}\\BIN"
end
