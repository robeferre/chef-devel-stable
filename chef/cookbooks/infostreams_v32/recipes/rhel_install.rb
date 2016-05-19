infostreams_package_file = Chef::Config[:file_cache_path] + "/" + node['infostreams']['pkg_file']
infostreams_response_path = node['infostreams']['cache'] + "/infostreams.properties"
infostreams_install_log = node['infostreams']['cache'] + "/infostreams_installation.log"
infostreams_source_file = node['infostreams']['bin_dir'] + "/streamsprofile.sh"
dynamic_url = "http://#{$BEST_SERVER}#{node['infostreams']['pkg_url']}"


if (!(File.directory?(node['infostreams']['base_install'])))
  
  # Creates the InfoStreams v3.2 Cache Directory
  log "Creating the InfoStreams Cache dir ..." 
  directory node['infostreams']['cache'] do
      owner "dstadmin"
      group "dstadmin"
      mode 0777
      action :create
  end
  
  # Download the installer packages
  log "Downloading InfoSphere Streams v.3.2 ..."  
  remote_file infostreams_package_file do
    source dynamic_url
    not_if { ::File.exists?(infostreams_package_file) }
  end
  
  # Change binaries permissions
  execute "Changing permissions from #{infostreams_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{infostreams_package_file}"
    action :run
  end
 
  # Adding streamsadmin user
  # dst4you
  execute "Adding user streams" do
    user "root"
    command "useradd streamsadmin -m -p 'Sn3tzLuiwAP9Q'"
    action :run
    not_if "grep streamsadmin /etc/passwd"
  end
  
  # Prepares the response files (intaller.properties)
  template infostreams_response_path do
    source "infostreams.properties.erb"
    owner  'streamsadmin'
    group  'streamsadmin'
    mode   '0600'
    action :touch
  end
  
  # Installing the libcurl-devel
  execute "Installing the libcurl-devel library" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "yum -y install libcurl-devel"
    action :run
  end
  
  execute "Installing the Development Tools library" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "yum groupinstall 'Development Tools' -y"
    action :run
  end
  
  log "Creating custom repo ..." 
  directory node['infostreams']['custom_repo'] do
   owner "streamsadmin"
   group "streamsadmin"
   mode 0755
   action :create
   not_if "ls -lhar #{node['infostreams']['custom_repo']}"
  end
  
  # Uncompressing the package files
  execute "Uncompressing the package installer..." do
    user "streamsadmin"
    group "streamsadmin"
    cwd Chef::Config[:file_cache_path]
    command "tar xvf #{infostreams_package_file} -C #{node['infostreams']['cache']}"
    action :run
    not_if "ls -lhar #{node['infostreams']['installer_dir']}"
  end
  
  cookbook_file "#{node['infostreams']['custom_repo']}/atrpms-77-1.noarch.rpm" do
   source "atrpms-77-1.noarch.rpm"
   mode '0655'
  end

  cookbook_file "#{node['infostreams']['custom_repo']}/perl-XML-Simple-2.18-6.el6.noarch.rpm" do
   source "perl-XML-Simple-2.18-6.el6.noarch.rpm"
   mode '0655'
  end
  
  yum_package "atrpms-77-1.noarch.rpm" do
    source node['infostreams']['custom_repo'] + "/atrpms-77-1.noarch.rpm"
  end

  yum_package "perl-XML-Simple-2.18-6.el6.noarch.rpm" do
    source node['infostreams']['custom_repo'] + "/perl-XML-Simple-2.18-6.el6.noarch.rpm"
  end
  

  # Execute the Installation
  execute "Installing InfoSphere Streams silently..." do
    user "streamsadmin"
    group "streamsadmin"
    returns [0,1]
    cwd node['infostreams']['installer_dir']
    command "./InfoSphereStreamsSetup.bin -i silent -f #{infostreams_response_path}"
    action :run
  end
  
  execute "Setting the InfoSphere Streams environment variables ..." do
    user "streamsadmin"
    group "streamsadmin"
    cwd node['infostreams']['user_home']
    command "echo 'source #{infostreams_source_file}' >> .bash_profile"
    action :run
  end
  
  execute "Setting the InfoSphere Streams environment variables ..." do
    user "streamsadmin"
    group "streamsadmin"
    cwd node['infostreams']['user_home']
    command "echo '#{node['infostreams']['bin_dir']}/streamtool genkey' >> .bash_profile"
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
  log "InfoSphere Streams v3.2 is already installed" do
  level :info
  end
end
