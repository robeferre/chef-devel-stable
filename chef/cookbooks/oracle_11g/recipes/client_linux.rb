package_file = Chef::Config[:file_cache_path] + "/" + node['oracle']['rhel']['client']['package_file']
oracle_tmp = node['oracle']['rhel']['client']['cache']
tmp_install = node['oracle']['rhel']['client']['tmp_install']
oracle_install_log = node['oracle']['rhel']['client']['cache'] + "/ora11g_installation.log"
response_path = node['oracle']['rhel']['client']['cache'] + "/oracle11g_client.rsp"
oraprofile_path = node['oracle']['rhel']['home_folder'] + "/oraprofile"
orainst_path = "/etc/oraInst.loc"
dynamic_url = "http://#{$BEST_SERVER}#{node['oracle']['rhel']['client']['pkg_url']}"
hostname = "#{node['hostname']}"


if (!(File.directory?(node['oracle']['rhel']['client']['basedir'])))
  
  directory node['oracle']['rhel']['client']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0777
      action :create
  end

  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end
  
  # Uncompressing the first zip installer
  execute "Uncompressing package installer ..." do
    cwd Chef::Config[:file_cache_path]
    command "unzip -o #{package_file} -d #{oracle_tmp}"
    action :run
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
  end
  
  execute "Updating the .bash_profile" do
    user "root"
    cwd node['oracle']['rhel']['home_folder']
    command "cat oraprofile >> .bash_profile"
    not_if "grep 'export ORACLE_BASE ORACLE_HOME ORACLE_BIN ORACLE_UNQNAME ORACLE_SID' /home/oracle/.bash_profile"
    action :run
  end
  
  execute "Changing permissions for oracle tmp dir ..." do
    user "root"
    command "chown -R oracle.oinstall #{node['oracle']['rhel']['client']['cache']}"
    action :run
  end
  
  template response_path do
    source "rhel_client11g.rsp.erb"
    action :touch
    variables({
      :host => "#{hostname}"
    })
  end
  
  # Installing the pam-devel library
  execute "Installing the pam-devel library" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install pam-devel"
    action :run
  end
  
  # Installing the pam library
  execute "Installing the pam.i686 library" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install pam.i686"
    action :run
  end
  
  # Installing the gcc,gc and another libraries
  execute "Installing the Development Tools library" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum groupinstall 'Development Tools' -y"
    action :run
  end
  
  # Installing the elfutils-libelf-devel library
  execute "Installing the elfutils-libelf-devel" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install elfutils-libelf-devel"
    action :run
  end
  
  # Installing the libaio-devel library
  execute "Installing the libaio-devel" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install libaio-devel"
    action :run
  end
  
  # Installing the unixODBC library
  execute "Installing the unixODBC" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install unixODBC"
    action :run
  end
  
  # Installing the unixODBC-devel library
  execute "Installing the unixODBC-devel" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install unixODBC-devel"
    action :run
  end
  
  # Installing the mksh library
  execute "Installing the mksh" do
    user "root"
    cwd node['oracle']['rhel']['client']['cache']
    command "yum -y install mksh"
    action :run
  end
  
  
  # Stopping the current Oracle database instance
  if (File.directory?(node['oracle']['rhel']['basedir']))
    execute "Stopping Oracle 11g service ..." do
      user "root"
      cwd node['oracle']['rhel']['client']['tmp_install']
      command "service oracle stop"
      only_if "ls -lhar /etc/init.d/oracle"
      action :run
    end
  
    execute "Stopping Oracle 11g service ..." do
      user "root"
      returns [0,2]
      cwd node['oracle']['rhel']['client']['tmp_install']
      command "su - oracle -c 'emctl stop dbconsole'"
      action :run
    end
    
    template orainst_path do
      source "oraInst.loc.erb"
      action :touch
      not_if "ls -lhar /etc/oraInst.loc"
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
  else
      # Creating the app directory
      directory node['oracle']['rhel']['appdir'] do
        action :create
        user   'oracle'
      end
      
      # Creating basedir directory
      directory node['oracle']['rhel']['basedir'] do
        action :create
        user   'oracle'
        recursive true
      end
      
      # Creating oradata directory
      directory node['oracle']['rhel']['oradata'] do
        action :create
        user   'oracle'
        recursive true
      end
      
      # Creating flash_recovery directory
      directory node['oracle']['rhel']['flash_recovery'] do
        action :create
        user   'oracle'
        recursive true
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
        action :run
      end
      
      execute "Creating symbolic link to #{node['oracle']['rhel']['flash_recovery']}" do
        user "root"
        cwd node['oracle']['rhel']['appdir']
        command "ln -s /flash_recovery_area #{node['oracle']['rhel']['flash_recovery']}"
        action :run
      end
  end
  
  
  
  # Installing Oracle11g
  execute "Installing Oracle11g" do
    user "root"
    cwd node['oracle']['rhel']['client']['tmp_install']
    command "su - oracle -c 'cd #{tmp_install};./runInstaller -silent -force -waitforcompletion -ignorePrereq -ignoreSysPrereqs -responseFile #{response_path} > #{oracle_install_log}'"
    action :run
  end
  
 
  # Remove Installers and garbage
  execute "Removing temporary files ..." do
   user "root"
   cwd Chef::Config[:file_cache_path]  
   command "rm -rf *"
   action :run
  end
  
  log "Installation Complete"  

else
  log "### Oracle 11g Client is currently installed. ###" do
  level :info
  end
end