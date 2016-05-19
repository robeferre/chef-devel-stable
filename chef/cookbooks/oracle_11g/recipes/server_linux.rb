cache_dir = Chef::Config[:file_cache_path]
package1_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['rhel']['package1_file']}"
package2_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['rhel']['package2_file']}"
oracle_tmp = node['oracle']['rhel']['cache']  
oracle_install_log = node['oracle']['rhel']['cache'] + "/ora11g_installation.log"
response_path = node['oracle']['rhel']['cache'] + "/rhel_oracle11g.rsp"
oraprofile_path = node['oracle']['rhel']['home_folder'] + "/oraprofile"
orastart_path = node['oracle']['rhel']['home_folder'] + "/ora_start.sh"
orastop_path = node['oracle']['rhel']['home_folder'] + "/ora_stop.sh"
oracle_initd_path = node['oracle']['rhel']['initd'] + "/oracle"
tmp_install = node['oracle']['rhel']['tmp_install']
orainst_path = "/etc/oraInst.loc"
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['rhel']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['rhel']['url_pkg2']}"
hostname = "#{node['hostname']}"


if (!(File.exists?(node['oracle']['rhel']['tnsnames'])))
  
  # Creating the oracle_install directory
  directory node['oracle']['rhel']['cache'] do
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
   
  # Adding orcl groups
  node['oracle']['rhel']['groups'].each do |group|
   execute "Adding group #{group}" do
     user "root"
     command "groupadd #{group}"
     action :run
     not_if "grep #{group} /etc/group"
   end
  end
  
  # Adding oracle user
  execute "Adding user oracle" do
    user "root"
    command "useradd oracle -g oinstall"
    action :run
    not_if "grep oracle /etc/passwd"
  end
  

  execute "Changing usermod for oracle" do
    user "root"
    command "usermod -a -G dba,oper,oinstall oracle"
    action :run
  end
  
  # Preparing oracle profile file
  template oraprofile_path do
    source "oraprofile.erb"
    action :touch
    user   'oracle'
    not_if "ls -lhar #{oraprofile_path}"
  end
  
  execute "Updating the .bash_profile" do
    user "root"
    cwd node['oracle']['rhel']['home_folder']
    command "cat oraprofile >> .bash_profile"
    not_if "grep 'export ORACLE_BASE ORACLE_HOME ORACLE_BIN ORACLE_UNQNAME ORACLE_SID' /home/oracle/.bash_profile"
    action :run
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
  
  
  # Creating the app directory
  directory node['oracle']['rhel']['appdir'] do
    action :create
    user   'oracle'
    not_if "ls -lhar #{node['oracle']['rhel']['appdir']}"
  end
  
  # Creating basedir directory
  directory node['oracle']['rhel']['basedir'] do
    action :create
    user   'oracle'
    recursive true
    not_if "ls -lhar #{node['oracle']['rhel']['basedir']}"
  end
  
  # Creating oradata directory
  directory node['oracle']['rhel']['oradata'] do
    action :create
    user   'oracle'
    recursive true
    not_if "ls -lhar #{node['oracle']['rhel']['oradata']}"
  end
  
  # Creating flash_recovery directory
  directory node['oracle']['rhel']['flash_recovery'] do
    action :create
    user   'oracle'
    recursive true
    not_if "ls -lhar #{node['oracle']['rhel']['flash_recovery']}"
  end
  
  
  # Changing permissions
  execute "Changing owner from #{node['oracle']['rhel']['appdir']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['rhel']['appdir']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['rhel']['appdir']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['rhel']['appdir']}"
    action :run
  end
  
  execute "Changing owner from #{node['oracle']['rhel']['oradata']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['rhel']['oradata']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['rhel']['oradata']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['rhel']['oradata']}"
    action :run
  end
  
  execute "Changing owner from #{node['oracle']['rhel']['flash_recovery']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chown -R oracle:oinstall #{node['oracle']['rhel']['flash_recovery']}"
    action :run
  end
  
  execute "Changing permissions from #{node['oracle']['rhel']['flash_recovery']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod -R 775 #{node['oracle']['rhel']['flash_recovery']}"
    action :run
  end
  
  
  # Creating symbolic links
  execute "Creating symbolic link to #{node['oracle']['rhel']['oradata']}" do
    user "root"
    cwd node['oracle']['rhel']['basedir']
    command "ln -s /oradata #{node['oracle']['rhel']['oradata']}"
    not_if "ls -lhar /opt/app/oradata/oradata"
    action :run
  end
  
  execute "Creating symbolic link to #{node['oracle']['rhel']['flash_recovery']}" do
    user "root"
    cwd node['oracle']['rhel']['appdir']
    command "ln -s /flash_recovery_area #{node['oracle']['rhel']['flash_recovery']}"
    not_if "ls -lhar /opt/app/oracle/flash_recovery_area"
    action :run
  end
  
  
  # Installing the pam-devel library
  execute "Installing the pam-devel library" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install pam-devel"
    action :run
  end
  
  # Installing the pam library
  execute "Installing the pam.i686 library" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install pam.i686"
    action :run
  end
  
  # Installing the gcc,gc and another libraries
  execute "Installing the Development Tools library" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum groupinstall 'Development Tools' -y"
    action :run
  end
  
  # Installing the elfutils-libelf-devel library
  execute "Installing the elfutils-libelf-devel" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install elfutils-libelf-devel"
    action :run
  end
  
  # Installing the libaio-devel library
  execute "Installing the libaio-devel" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install libaio-devel"
    action :run
  end
  
  # Installing the unixODBC library
  execute "Installing the unixODBC" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install unixODBC"
    action :run
  end
  
  # Installing the unixODBC-devel library
  execute "Installing the unixODBC-devel" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install unixODBC-devel"
    action :run
  end
  
  # Installing the mksh library
  execute "Installing the mksh" do
    user "root"
    cwd node['oracle']['rhel']['cache']
    command "yum -y install mksh"
    action :run
  end
  
  execute "Changing oracle soft nproc value" do
    user "root"
    command "echo 'oracle  soft    nproc   2047' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* soft nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end
  
  execute "Changing oracle hard nproc value" do
    user "root"
    command "echo 'oracle  hard    nproc   16384' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* hard nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end

  execute "Changing oracle hard nofile value" do
    user "root"
    command "echo 'oracle  soft    nofile  4096' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* soft nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end
  
  execute "Changing oracle hard nofile value" do
    user "root"
    command "echo 'oracle  hard    nofile  65536' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* hard nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end

  execute "Changing oracle soft stack value" do
    user "root"
    command "echo 'oracle  soft    stack   10240' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* soft nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end
  
  execute "Changing oracle hard stack value" do
    user "root"
    command "echo 'oracle  hard    stack   32768' >> #{node['oracle']['rhel']['limits_conf'] }"
    not_if "grep '* hard nofile 99999' #{node['oracle']['rhel']['limits_conf']}"
    action :run
  end
  
  
  # Preparing the Response File
  template response_path do
    source "rhel_oracle11g.rsp.erb"
    action :touch
    user   'oracle'
    variables({
      :host => "#{hostname}"
    })
  end
  
   # Installing Oracle11g
  execute "Updating kernel parameters ..." do
    user "root"
    returns [0]
    cwd node['oracle']['rhel']['tmp_install']
    command "ulimit -n 10240;echo 250 1024000 32 4096 > /proc/sys/kernel/sem"
    action :run
  end
  
  template orainst_path do
   source "oraInst.loc.erb"
   action :touch
   not_if "ls -lhar #{orainst_path}"
  end
  
  execute "Changing groups for oraInst.loc ..." do
    user "root"
    command "chown oracle.oinstall #{orainst_path}"
    action :run
  end
    
  execute "Changing permissions for oraInst.loc ..." do
    user "root"
    command "chmod 777 #{orainst_path}"
    action :run
  end
  
 # Installing Oracle11g
  execute "Installing Oracle11g" do
    user "root"
    returns [0,253]
    cwd node['oracle']['rhel']['tmp_install']
    timeout 10800
    command "su - oracle -c 'cd #{tmp_install};./runInstaller -silent -force -waitforcompletion -ignorePrereq -ignoreSysPrereqs -responseFile #{response_path} > #{oracle_install_log}'"
    action :run
  end
  
  # # Post installation process
  # execute "Registering instance ...." do
    # user "root"
    # cwd node['oracle']['rhel']['ora_root'] 
    # command "./root.sh"
    # action :run
  # end
  
  
  # execute "Enabling auto start on reboot ...." do
    # user "root"
    # command "sed -i '$ s/N/Y/g' /etc/oratab"
    # action :run
  # end
  
  # Preparing the script file
  # template orastart_path do
    # source "rhel_ora_start.sh.erb"
    # action :touch
    # user   'oracle'
  # end
#   
  # template orastop_path do
    # source "rhel_ora_stop.sh.erb"
    # action :touch
    # user   'oracle'
  # end
#   
  # # Creates start/stop scripts
  # execute "Updating the start/stop scripts ..." do
    # user "oracle"
    # cwd node['oracle']['rhel']['home_folder']
    # command "chmod u+x ora_start.sh ora_stop.sh"
    # action :run
  # end
#   
  # template oracle_initd_path do
    # source "rhel_oracle.erb"
    # action :touch
    # user   'oracle'
  # end
    
  # execute "Updating the /etc/init.d/oracle script ..." do
    # user "root"
    # cwd node['oracle']['rhel']['initd']
    # command "chmod 755 /etc/init.d/oracle"
    # action :run
  # end
  
  # execute "Creating the oracle service ..." do
    # user "root"
    # cwd node['oracle']['rhel']['initd']
    # command "chkconfig --add oracle"
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
  log "Oracle 11g is currently installed on this machine." do
  level :info
  end
end