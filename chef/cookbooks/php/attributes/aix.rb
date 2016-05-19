case node['platform_family']
when 'aix'
#  default['php']['url'] = 'http://dst.lexington.ibm.com/install/CHEF_FILES/PHP/php-5.5.10.tar.gz'
  default['php']['url'] = 'https://dl.dropboxusercontent.com/s/0hf0008j94am17l/php-5.5.10.tar.gz?dl=1&token_hash=AAHVFkKpqEqw5-G31laeIuzQhJR57SIk4plYADYgrRGRvw'
  default['php']['file'] = "php-5.5.10.tar.gz"
  default['php']['cache'] = Chef::Config[:file_cache_path] + "/php_install"
  default['php']['php_files'] = node['php']['cache'] + "/php-5.5.10"
  default['php']['config_file'] = "/usr/local/lib/php.ini"
  default['php']['lib_dir'] = "/usr/local/lib/"
end