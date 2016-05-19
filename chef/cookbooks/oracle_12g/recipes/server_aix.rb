cache_dir = Chef::Config[:file_cache_path]
package1_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['aix']['package1_file']}"
package2_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['aix']['package2_file']}"
oracle_tmp = node['oracle']['aix']['cache']  
response_path = node['oracle']['aix']['cache'] + "/aix_oracle12g.rsp"
tmp_install = node['oracle']['aix']['tmp_install']
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['aix']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['aix']['url_pkg2']}"


if (!(File.directory?(node['oracle']['aix']['basedir'])))
  
  # Creating the oracle_install directory
  directory node['oracle']['aix']['cache'] do
    action :create
  end
  
  # Getting the frist package installer
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
    command "useradd -m oracle"
    action :run
    not_if "grep oracle /etc/passwd"
  end
  
  # Adding oracle user
  execute "Changing usermod for oracle" do
    user "root"
    command "usermod -G dba,oper,oinstall oracle"
    action :run
  end
  
  # Preparing the Response File
  template response_path do
    source "aix_oracle12g.rsp.erb"
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
  
 # Installing Oracle12g
  execute "Executing prereq from root.sh" do
    user 'root'
    cwd node['oracle']['aix']['tmp_install']
    command "cd #{tmp_install};./rootpre.sh"
    action :run
  end
    
 # Installing Oracle12g
  execute "Installing Oracle12g" do
    cwd node['oracle']['aix']['tmp_install']
    command "su - oracle -c 'cd #{tmp_install};SKIP_ROOTPRE=TRUE; export SKIP_ROOTPRE;./runInstaller -silent -responseFile #{response_path} -ignorePrereq -waitforcompletion;exit 0'"
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