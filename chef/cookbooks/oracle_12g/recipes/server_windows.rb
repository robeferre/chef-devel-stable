require 'win32/service'

package1_file = Chef::Config[:file_cache_path] + "\\" + node['oracle']['windows']['package1_file']
package2_file = Chef::Config[:file_cache_path] + "\\" + node['oracle']['windows']['package2_file']
oracle_tmp = node['oracle']['windows']['cache']  
response_path = node['oracle']['windows']['cache'] + "\\oracle12g.rsp"
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['windows']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['windows']['url_pkg2']}"

if (!(File.directory?(node['oracle']['windows']['basedir'])))
  
  directory node['oracle']['windows']['cache'] do
    action :create
  end

  remote_file package1_file do
    source dynamic_url1
    not_if { ::File.exists?(package1_file) }
  end
  
  remote_file package2_file do
    source dynamic_url2
    not_if { ::File.exists?(package2_file) }
  end
  
  windows_zipfile oracle_tmp do
    source package1_file
    action :unzip
  end
  
  windows_zipfile oracle_tmp do
    source package2_file
    action :unzip
  end
  
  template response_path do
    source "win_oracle12g.rsp.erb"
    action :touch
  end
    
  # Installing Oracle12g
  execute "Installing Oracle12g" do
    cwd node['oracle']['windows']['tmp_install']
    command "setup.exe -noconsole -silent -responseFile #{response_path} -waitforcompletion"
    action :run
  end
  
    # Garbage collector
#  execute "Removing temp files ..." do
#    user "root"
#    cwd Chef::Config[:file_cache_path]
#    command "rm -Rf #{node['db2']['cache']}"
#    action :run
#  end

else
  log "### Oracle 12g is currently installed. ###" do
  level :info
  end
end