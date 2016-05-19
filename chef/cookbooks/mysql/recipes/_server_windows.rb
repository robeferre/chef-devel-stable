require 'win32/service'


ENV['PATH'] += ";#{node['mysql']['windows']['bin_dir']}"
package_file = Chef::Config[:file_cache_path] + node['mysql']['windows']['package_file']
install_dir = win_friendly_path(node['mysql']['windows']['basedir'])

if (!(File.directory?(node['mysql']['windows']['data_dir'])))

  def package(*args, &blk)
    windows_package(*args, &blk)
  end
  
  remote_file package_file do
    source node['mysql']['windows']['url']
    not_if { ::File.exists?(package_file) }
  end
  
  
  windows_package 'Uncompressing the MSI'  do
    source package_file
    action :install
  end
  
  windows_package 'Installing MySQL Server' do
    source node['mysql']['windows']['install_dir'] + "MySQLInstallerConsole.exe" 
    options '--config=mysql-server-5.6-winx64:passwd=root --product=* --catalog=mysql-5.6-winx64 --action=install --type=full --nowait'
    installer_type :custom
    action :install
  end

else
  log "MySQL Server is already installed." do
  level :info
  end
end