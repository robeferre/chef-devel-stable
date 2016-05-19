require 'win32/service'

package_file = Chef::Config[:file_cache_path] + "\\" + node['oracle']['windows']['client']['package_file']
oracle_tmp = node['oracle']['windows']['client']['cache']  
response_path = node['oracle']['windows']['client']['cache'] + "\\oracle11g_client.rsp"
dynamic_url = "http://#{$BEST_SERVER}#{node['oracle']['windows']['client']['pkg_url']}"
hostname = "#{node['hostname']}"


if (!(File.directory?(node['oracle']['windows']['client']['basedir'])))
  
  directory node['oracle']['windows']['client']['cache'] do
    action :create
  end

  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end
  
  windows_zipfile oracle_tmp do
    source package_file
    action :unzip
  end
  
  template response_path do
    source "win_client11g.rsp.erb"
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

  windows_path "#{ENV['SYSTEMDRIVE']}\\app\\oracle\\product\\11.2.0\\dbhome_3\\bin" do
    action :add
  end
   
  # Installing Oracle11g
  execute "Installing Oracle11g" do
    cwd node['oracle']['windows']['client']['tmp_install']
    command "setup.exe -noconsole -silent -responseFile #{response_path} -waitforcompletion"
    action :run
  end
  
   # Remove Installers and garbage
  execute "Removing temporary files ..." do
   cwd Chef::Config[:file_cache_path]  
   command "del /q *.* && for /d %x in (*.*) do @rd /s /q %x"
   action :run
  end
  
  log "Installation Complete"  

else
  log "### Oracle 11g Client is currently installed. ###" do
  level :info
  end
end