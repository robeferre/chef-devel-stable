case node['platform_family']
when 'rhel'
  default['php']['url'] = "http://#{$BEST_SERVER}/install/CHEF_FILES/PHP/php-5.5.10.tar.gz"
  default['php']['file'] = "php-5.5.10.tar.gz"
  default['php']['cache'] = Chef::Config[:file_cache_path] + "/php_install"
  default['php']['php_files'] = node['php']['cache'] + "/php-5.5.10"
  default['php']['config_file'] = "/usr/local/lib/php.ini"
  default['php']['lib_dir'] = "/usr/local/lib/"
end