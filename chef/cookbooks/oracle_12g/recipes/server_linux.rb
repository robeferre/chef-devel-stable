cache_dir = Chef::Config[:file_cache_path]
package1_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['rhel']['package1_file']}"
package2_file = Chef::Config[:file_cache_path] + "/#{node['oracle']['rhel']['package2_file']}"
oracle_tmp = node['oracle']['rhel']['cache']  
response_path = node['oracle']['rhel']['cache'] + "/rhel_oracle12g.rsp"
tmp_install = node['oracle']['rhel']['tmp_install']
dynamic_url1 = "http://#{$BEST_SERVER}#{node['oracle']['rhel']['url_pkg1']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['oracle']['rhel']['url_pkg2']}"


if (!(File.directory?(node['oracle']['rhel']['basedir'])))
  
  # Creating the oracle_install directory
  directory node['oracle']['rhel']['cache'] do
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
    command "useradd oracle"
    action :run
    not_if "grep oracle /etc/passwd"
  end
  
  # Adding oracle user
  execute "Changing usermod for oracle" do
    user "root"
    command "usermod -a -G dba,oper,oinstall oracle"
    action :run
  end
  
  # Preparing the Response File
  template response_path do
    source "rhel_oracle12g.rsp.erb"
    action :touch
    user   'oracle'
  end
  
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
    
 # Installing Oracle12g
  execute "Installing Oracle12g" do
    cwd node['oracle']['rhel']['tmp_install']
    command "su - oracle -c 'cd #{tmp_install};./runInstaller -silent -responseFile #{response_path} -ignorePrereq -waitforcompletion'"
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