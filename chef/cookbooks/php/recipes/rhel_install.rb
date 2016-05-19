package_file = Chef::Config[:file_cache_path] + "/" + node['php']['file']
ini_file_path = node['php']['cache'] + "/php.ini"
install_log_path = node['php']['cache'] + "/silent_install.log"
tmp_install_path = node['php']['php_files']
php_cache_dir = node['php']['cache']
lib_path_dir = node['php']['lib_dir']


# Testing if the php is already installed
if (!(File.exists?(node['php']['config_file'])))
  
  # Creating the temporary dir
  log "Creating the cache directory ..." 
  directory node['php']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0755
      action :create
  end
  
  
  # Getting the installation package
  remote_file package_file do
    source node['php']['url']
    not_if { ::File.exists?(package_file) }
  end
 
  # Uncompressing php zip file
  bash "untar_php" do
    code <<-EOL
    tar zxf #{package_file} -C #{php_cache_dir}
    EOL
  end
    
  # Installing the gcc,gc and another libraries
  execute "Installing the Development Tools library" do
    user "root"
    cwd node['php']['cache']
    command "yum groupinstall 'Development Tools' -y"
    action :run
  end
  
  # Installing the libxml2
  execute "Installing the libxml2 library" do
    user "root"
      cwd node['php']['cache']
    command "yum install libxml2-devel -y"
    action :run
  end
  
  # Preparing the template file
  template ini_file_path do
    source "php.ini.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  # Performing the PHP's installation
  log "Running php installation" 
   bash "install_php" do
    returns [0, 1]    
    code <<-EOL
    cd #{tmp_install_path}
    ./configure > #{install_log_path}
    make >> #{install_log_path}
    make install >> #{install_log_path}
    EOL
  end
  
  # Copy the php.ini file to the destination dir
  execute "Installing the libxml2 library" do
    user "root"
    cwd node['php']['cache']
    command "cp #{ini_file_path} #{lib_path_dir}"
    action :run
  end
  
else
  log "PHP v5.5.10 is already installed!" do
  level :info
  end
end
