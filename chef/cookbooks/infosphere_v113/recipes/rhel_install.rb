is_package_file = Chef::Config[:file_cache_path] + "/" + node['is']['is_file']
img_package_file = Chef::Config[:file_cache_path] + "/" + node['is']['img_file']
is_response_path = node['is']['cache'] + "/is_suite.rsp"
is_install_log = node['is']['cache'] + "/is_installation.log"
dynamic_url1 = "http://#{$BEST_SERVER}#{node['is']['is_url']}"
dynamic_url2 = "http://#{$BEST_SERVER}#{node['is']['img_url']}"
host_name = "#{node['fqdn']}"
domain_name = "#{node['domain']}"

if (!(File.directory?(node['is']['base_dir'])))
  
  # Creates the IS Cache Directory
  log "Creating the is Cache dir ..." 
  directory node['is']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0755
      action :create
  end
  
  # Download the installation packages
  log "Getting the InfoSphere Information Server image ..."  
  remote_file is_package_file do
    source dynamic_url1
    not_if { ::File.exists?(is_package_file) }
  end
  
  log "Getting the InfoSphere License Image ..."  
  remote_file img_package_file do
    source dynamic_url2
    not_if { ::File.exists?(img_package_file) }
  end
  
  # Installing the libXp library
  execute "Installing the libXp library ..." do
    user "root"
    cwd node['is']['cache']
    command "yum -y install libXp.x86_64"
    action :run
  end
  
  # Installing the pam-devel library
  execute "Installing the pam-devel library" do
    user "root"
    cwd node['is']['cache']
    command "yum -y install pam-devel"
    action :run
  end
  
  # Installing the pam library
  execute "Installing the pam.i686 library" do
    user "root"
    cwd node['is']['cache']
    command "yum -y install pam.i686"
    action :run
  end
  
  # Installing the compat-libstdc++-33 library
  execute "Installing the compat-libstdc++-33" do
    user "root"
    cwd node['is']['cache']
    command "yum -y install compat-libstdc++-33"
    action :run
  end
  
  # Change package permissions
  execute "Changing permissions from #{is_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{is_package_file}"
    action :run
  end
  
  execute "Changing permissions from #{img_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{img_package_file}"
    action :run
  end
  
  # Uncompressing the package files
  execute "Uncompressing the IS package installer ..." do
    user "root"
    cwd node['is']['cache']
    command "tar xvf #{is_package_file}"
    action :run
  end
  
  execute "Uncompressing the IS Image file ..." do
    user "root"
    cwd node['is']['cache']
    command "unzip -o #{img_package_file} -d #{node['is']['installer_dir']}"
    action :run
  end
  
  # Changing permissions
  execute "Changing permissions from #{node['is']['installer_dir']}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{node['is']['installer_dir']}"
    action :run
  end
 
 # Creating administrative groups
  node['is']['groups'].each do |group| 
    execute "Creating group: #{group}" do
      user "root"
      cwd node['is']['cache']
      command "groupadd #{group}"
      not_if "grep #{group} /etc/group"
      action :run
    end
  end   
  
 # Creating administrative users
  log "Creating Administrative users ..."
  node['is']['users'].each do |user,pass| 
    execute "Adding user: #{user}" do
      user "root"
      cwd node['is']['cache']
      command "useradd #{user} -m -p #{pass}"
      not_if "grep #{user} /etc/passwd"
      action :run
    end
  end
  
    
  # Prepares the response file
  template is_response_path do
    source "is_suite.rsp.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
    variables({
      :host => "#{host_name}"
    })
  end
  
  # Run the installer
  execute "Installing  InfoSphere Information Server v11.3 ..." do
    user "root"
    returns [0]
    cwd node['is']['installer_dir']
    timeout 10800
    command "ulimit -n 10240;umask 022;echo 250 1024000 32 4096 > /proc/sys/kernel/sem;./setup -rsp #{is_response_path} -uiMode silent -reportFile #{is_install_log}"
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
  log "IBM InfoSphere v11.3 is already installed on this machine." do
  level :info
  end
end
