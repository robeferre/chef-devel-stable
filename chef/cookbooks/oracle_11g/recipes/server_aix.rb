cache_dir = Chef::Config[:file_cache_path]
package1_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['aix']['package1_file']}"
package2_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['aix']['package2_file']}"
oracle_tmp = node['oracle']['aix']['cache']
oracle_install_log = node['oracle']['aix']['cache'] + "/ora11g_installation.log"
response_path = node['oracle']['aix']['cache'] + "/aix_oracle11g.rsp"
dbora_path = node['oracle']['aix']['initd'] + "/dbora"
oraprofile_path = node['oracle']['aix']['home_folder'] + "/oraprofile"
tmp_install = node['oracle']['aix']['tmp_install']
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['aix']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['aix']['url_pkg2']}"
hostname = "#{node['hostname']}"


if (!(File.directory?(node['oracle']['aix']['basedir'])))
  
  # Creating the oracle_install directory
  directory node['oracle']['aix']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0777
      action :create
  end
  
  # Getting the first package installer
  remote_file package1_file do
    source dynamic_url1
    not_if { ::File.exists?(package1_file) }
  end
  
  # Getting the second package installer
  remote_file package2_file do
    source dynamic_url2
    not_if { ::File.exists?(package2_file) }
  end
  
  # Uncompressing the first zip installer
  execute "Uncompressing package 1 of 2" do
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{package1_file} -d #{oracle_tmp}"
    action :run
  end
  
  # Uncompressing the second zip installer
  execute "Uncompressing package 2 of 2" do
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{package2_file} -d #{oracle_tmp}"
    action :run
  end
  
  # Adding orcl groups
  node['oracle']['aix']['groups'].each do |group|
   execute "Adding group #{group}" do
     user "root"
     command "mkgroup #{group}"
     action :run
     not_if "grep #{group} /etc/group"
   end
  end
  
  # Adding oracle user
  execute "Adding user oracle" do
    user "root"
    command "useradd -g oinstall -m oracle"
    action :run
    not_if "grep oracle /etc/passwd"
  end
  
  # Changing the oracle user permissions
  execute "Changing usermod for oracle" do
    user "root"
    command "usermod -G dba,oper,oinstall oracle"
    action :run
  end
  
  # Preparing oracle profile file
  template oraprofile_path do
    source "oraprofile.erb"
    action :touch
    user   'oracle'
  end
  
  execute "Updating the .bash_profile" do
    user "root"
    cwd node['oracle']['aix']['home_folder']
    command "cat oraprofile >> .profile"
    not_if "grep 'export ORACLE_BASE ORACLE_HOME ORACLE_BIN ORACLE_UNQNAME ORACLE_SID' /home/oracle/.bash_profile"
    action :run
  end
  
  
  # Creating the app directory
  directory node['oracle']['aix']['appdir'] do
    action :create
    user   'oracle'
  end
  
  # Creating basedir directory
  directory node['oracle']['aix']['basedir'] do
    action :create
    user   'oracle'
    recursive true
  end
  
  # Creating oradata directory
  directory node['oracle']['aix']['oradata'] do
    action :create
    user   'oracle'
    recursive true
  end
  
  # Creating flash_recovery directory
  directory node['oracle']['aix']['flash_recovery'] do
    action :create
    user   'oracle'
    recursive true
  end
  
  
  # Changing permissions
  execute "Changing owner from #{node['oracle']['aix']['appdir']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['aix']['appdir']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['aix']['appdir']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['aix']['appdir']}"
    action :run
  end
  
  execute "Changing owner from #{node['oracle']['aix']['oradata']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['aix']['oradata']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['aix']['oradata']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['aix']['oradata']}"
    action :run
  end
  
  execute "Changing owner from #{node['oracle']['aix']['flash_recovery']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['aix']['flash_recovery']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['aix']['flash_recovery']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['aix']['flash_recovery']}"
    action :run
  end
  
  
  # Creating symbolic links
  execute "Creating symbolic link to #{node['oracle']['aix']['oradata']}" do
    user "root"
    cwd node['oracle']['aix']['basedir']
    command "ln -s /oradata #{node['oracle']['aix']['oradata']}"
    action :run
  end
  
  execute "Creating symbolic link to #{node['oracle']['aix']['flash_recovery']}" do
    user "root"
    cwd node['oracle']['aix']['appdir']
    command "ln -s /flash_recovery_area #{node['oracle']['aix']['flash_recovery']}"
    action :run
  end
  
  # Preparing the Response File
  template response_path do
    source "aix_oracle11g.rsp.erb"
    action :touch
    user   'oracle'
  end
  
  # Creating the app directory
  directory node['oracle']['aix']['appdir'] do
    action :create
    user   'oracle'
  end
  
  # Creating basedir directory
  directory node['oracle']['aix']['basedir'] do
    action :create
    user   'oracle'
    recursive true
  end
  
 # Installing Oracle11g
  execute "Executing prereq from root.sh" do
    user 'root'
    cwd node['oracle']['aix']['tmp_install']
    command "./rootpre.sh"
    action :run
  end
    
 # Installing Oracle11g
  execute "Installing Oracle11g" do
    returns [0,3]
    cwd node['oracle']['aix']['tmp_install']
    timeout 10800
    command "su - oracle -c 'cd #{tmp_install};SKIP_ROOTPRE=TRUE; export SKIP_ROOTPRE;./runInstaller -waitforcompletion -ignoreSysPrereqs -silent -responseFile #{response_path} > #{oracle_install_log}'"
    action :run
  end
  
  # # Post installation process
  # execute "Registering instance ...." do
    # user "root"
    # cwd node['oracle']['aix']['ora_root'] 
    # command "./root.sh"
    # action :run
  # end
#   
  # execute "Enabling auto start on reboot ...." do
    # user "root"
    # command "sed '$ s/N/Y/g' /etc/oratab"
    # action :run
  # end
#   
  # # Preparing oracle profile file
  # template dbora_path do
    # source "dbora.erb"
    # action :touch
    # user   'oracle'
  # end
#   
  # execute "Changing group from dbora ..." do
   # user "root"
   # cwd node['oracle']['aix']['initd']
   # command "chgrp dba dbora"
   # action :run
  # end
#   
  # execute "Changing permissions from dbora..." do
   # user "root"
   # cwd node['oracle']['aix']['initd']
   # command "chmod 750 dbora"
   # action :run
  # end
#   
  # execute "Creating symbolic link 1/2 ..." do
   # user "root"
   # cwd node['oracle']['aix']['cache']
   # command "ln -s /etc/dbora /etc/rc.d/rc2.d/S99dbora"
   # not_if "ls -la /etc/rc.d/rc2.d/S99dbora"
   # action :run
  # end
#   
  # execute "Creating symbolic link 2/2 ..." do
   # user "root"
   # cwd node['oracle']['aix']['cache']
   # command "ln -s /etc/dbora /etc/rc.d/rc2.d/K01dbora"
   # not_if "ls -la /etc/rc.d/rc2.d/K01dbora"
   # action :run
  # end
  
  # Remove Installers and garbage
  execute "Removing temporary files ..." do
   user "root"
   cwd Chef::Config[:file_cache_path]
   command "rm -rf *"
   action :run
  end
  
  log "Installation Complete"  
 
else
  log "### Oracle 11g is currently installed. ###" do
  level :info
  end
end