require 'win32/service'

package1_file = Chef::Config[:file_cache_path] + "\\" + node['oracle']['windows']['package1_file']
package2_file = Chef::Config[:file_cache_path] + "\\" + node['oracle']['windows']['package2_file']
oracle_tmp = node['oracle']['windows']['cache']  
response_path = node['oracle']['windows']['cache'] + "\\oracle11g.rsp"
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['windows']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['windows']['url_pkg2']}"
hostname = "#{node['hostname']}"

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
    source "win_oracle11g.rsp.erb"
    action :touch
    variables({
      :host => "#{hostname}"
    })
  end
  
  # Declaring environment variables
  node['oracle']['windows']['paths'].each do |name,value|
    env "#{name}" do
      value "#{value}"
    end
  end
  
  # Installing Oracle11g
  execute "Installing Oracle11g" do
    cwd node['oracle']['windows']['tmp_install']
    command "setup.exe -noconsole -silent -responseFile #{response_path} -waitforcompletion"
    action :run
  end
  
  windows_path "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\product\\11.2.0\\dbhome_3\\bin" do
    action :add
  end
  
  # Remove Installers and garbage
  execute "Removing temporary files ..." do
   cwd Chef::Config[:file_cache_path]
   command "del /q *.* && for /d %x in (*.*) do @rd /s /q %x"
   action :run
  end
  
  log "Installation Complete"  

else
  log "### Oracle 11g is currently installed. ###" do
  level :info
  end
end