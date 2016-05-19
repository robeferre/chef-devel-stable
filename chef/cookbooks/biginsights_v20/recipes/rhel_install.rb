###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# Infosphere BigInsights V2.0 for Linux
#
##################################################################################################################################

bi_package_file = Chef::Config[:file_cache_path] + "/" + node['biginsights']['file']
bi_response_path = node['biginsights']['cache'] + "/bi_install.rsp.xml"
bi_install_log = node['biginsights']['cache'] + "/bi_installation.log"
dynamic_url= "http://#{$BEST_SERVER}#{node['biginsights']['url']}"
host_name = "#{node['fqdn']}"
domain_name = "#{node['domain']}"
access_query = "root@" + node['ipaddress']


# Testing if the BigInsghts is already installed
if (!(File.directory?(node['biginsights']['base_dir'])))
  
  directory node['biginsights']['cache'] do
    owner "biadmin"
    group "biadmin"
    mode "0755"
    recursive true
    action :create
  end  

  # Getting the package file
  log "Getting the IBM BigInsights v2.0 installer ..." 
  remote_file bi_package_file do
   source dynamic_url
   not_if { ::File.exists?(bi_package_file) }
  end

  # Installing the gcc,gc and another libraries
  execute "Installing the Development Tools library" do
    user "root"
    cwd node['biginsights']['cache']
    command "yum groupinstall 'Development Tools' -y"
    action :run
  end


  # Installing the expect tool
  execute "Installing the expect tool" do
    user "root"
    cwd node['biginsights']['cache']
    command "yum install expect -y"
    action :run
  end

  # Creating administrative users and groups
  # dst4you
  execute "Adding user: biadmin" do
    user "root"
    cwd node['biginsights']['cache']
    command "useradd biadmin -m -p 'Sn3tzLuiwAP9Q'"
    not_if "grep biadmin /etc/passwd"
    action :run
  end


  # Add the biadmin user to the sudoers group.
  execute "Add biadmin user to the sudoers group list ..." do
    user "root"
    cwd node['biginsights']['cache']
    command "echo '%biadmin  ALL=(ALL)  NOPASSWD: ALL' >> /etc/sudoers"
    action :run
    not_if "grep %biadmin /etc/sudoers"
  end

  # Generating ssh keys for root
  execute "Generating the ssh keys ..." do
    user "root"
    cwd node['biginsights']['cache']
    command "echo -e  'y'|ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa"
    action :run
  end
  
  execute "Copying the ssh key ..." do
   user "root"
   cwd node['biginsights']['cache']
   command "cat ~/.ssh/id_rsa.pub >>  ~/.ssh/authorized_keys"
   action :run
  end
  
  # Generating ssh keys for biadmin
  execute "Generating the ssh keys - biadmin ..." do
    user "biadmin"
    cwd node['biginsights']['cache']
    command "su - biadmin;echo -e  'y'|ssh-keygen -q -t rsa -N '' -f /home/biadmin/.ssh/id_rsa"
    action :run
  end
  
  # Changing permissions from the tar.gz file to 0777
  execute "Changing permissions from #{bi_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{bi_package_file}"
    action :run
  end
  
	# Uncompressing package file
	execute "Uncompressing the .tar.gz file ..." do
	  user "root"
	  cwd node['biginsights']['cache']
	  command "tar xvf #{bi_package_file} -C #{node['biginsights']['cache']}"
    action :run
	end

	# Creating the response file
	template bi_response_path do
  	source "bi_install.rsp.xml.erb"
  	owner  'biadmin'
  	group  'biadmin'
  	mode   '0600'
  	variables({
      :ipnode => node['ipaddress']
    })
  	action :create_if_missing
	end
  
  # Changing permissions from the installer dir to 0777
  execute "Changing permissions from #{bi_package_file}" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "chmod 0777 #{node['biginsights']['installer_dir']} -R"
    action :run
  end
  
  # Update to auto accept known_hosts
  execute "Including known_hosts value ..." do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "echo StrictHostKeyChecking no >> /etc/ssh/ssh_config"
    action :run
  end
        
  # Installing the IBM BigInsights v2.0
	execute "Installing BigInsghts ..." do
	 user "root"
	 cwd node['biginsights']['silent']
	 command "./silent-install.sh #{bi_response_path}"
	 action :run
	end
	
	# Removing the auto accept
  execute "Including known_hosts value ..." do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "sed '$d' /etc/ssh/ssh_config"
    action :run
  end

  # Remove Installers and garbage
  execute "Removing temporary files ..." do
   user "root"
   cwd Chef::Config[:file_cache_path]
   command "rm -rf *"
   action :run
  end
	
  log "Hostname: #{node['hostname']} IP Adress: #{node['ipaddress']} Domain: #{node['fqdn']}"
else
  log "The IBM Infosphere BigInsghts is already installed on this machine." do
  level :info
  end
end



