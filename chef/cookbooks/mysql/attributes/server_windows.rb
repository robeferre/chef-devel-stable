case node['platform_family']
when 'windows'
  default['mysql']['windows']['package_file']       = "mysql-installer-community-5.6.15.0.msi"
  default['mysql']['windows']['packages']           = ['MySQL Installer']
  default['mysql']['windows']['url']                = "http://dev.mysql.com/get/Downloads/MySQLInstaller/mysql-installer-community-5.6.15.0.msi"
  default['mysql']['windows']['checksum'] 			= "375458d0e5d5343f6d6220d90cfcb81a"
  default['mysql']['windows']['version']            = '5.6.15.0'
  default['mysql']['windows']['display_name']       = "MySQL Server #{ node['mysql']['windows']['version'] }"
 #default['mysql']['windows']['arch']              = 'win32'

  default['mysql']['windows']['basedir']            = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\#{node['mysql']['windows']['packages'].first}"
  default['mysql']['windows']['data_dir']           = "#{node['mysql']['windows']['basedir']}\\Data"
  default['mysql']['windows']['bin_dir']            = "#{node['mysql']['windows']['basedir']}\\bin"
  default['mysql']['windows']['mysqladmin_bin']     = "#{node['mysql']['windows']['bin_dir']}\\mysqladmin"
  default['mysql']['windows']['mysql_bin']          = "#{node['mysql']['windows']['bin_dir']}\\mysql"
  default['mysql']['windows']['install_dir']          = "#{node['mysql']['windows']['basedir']}\\"

  default['mysql']['windows']['conf_dir']           = "#{node['mysql']['windows']['basedir']}\\"
  default['mysql']['windows']['old_passwords']      = 0
  default['mysql']['windows']['grants_path']        = "#{node['mysql']['conf_dir']}\\grants.sql"

  default['mysql']['server']['service_name']        = 'mysql'
end
