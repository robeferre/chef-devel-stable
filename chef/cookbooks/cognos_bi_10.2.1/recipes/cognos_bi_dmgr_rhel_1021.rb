#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# IBM Cognos BI Data Manager Modules V10.2.1 for Linux
#
#################################################################
dmgr_package_file = Chef::Config[:file_cache_path] + "/" + node['cognos1021']['dmgr']['pkg_file']

dmgr_dynamic_url = "http://#{$BEST_SERVER}#{node['cognos1021']['dmgr']['url']}"
dmgr_response_path = node['cognos1021']['dmgr']['cache_path'] + "/cognos_bi_dmgr_1021.ats"
dmgr_installer_path = node['cognos1021']['dmgr']['cache_path'] + "/linuxi38664h"


	# Create Cognos temporary dir
	log "Creating Cognos Data Manager Modules ..."
	directory node['cognos1021']['dmgr']['cache_path'] do
	  owner "root"
	  group "root"
	  mode "0755"
	  action :create
	  recursive true
	end   
  
	log "Downloading Cognos BI v10.2.1 Data Manager ..." 
	remote_file dmgr_package_file do
	  source dmgr_dynamic_url
	  action :create_if_missing
	end

	# Uncompressing the installation files
	execute "Uncompressing the Cognos BI Dmgr ..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xvf #{dmgr_package_file} -C #{node['cognos1021']['dmgr']['cache_path']}"
	  action :run
	end

    # Create response file
	template dmgr_response_path do
		source "cognos_bi_dmgr_1021.ats.erb"	
		owner 'root'
		group 'root'
		mode '0600'
		action :touch
	end

	# Installing IBM Cognos Data Manager Modules
    execute "Installing Cognos BI 10.2.1 Data Manager Modules ..." do
      cwd dmgr_installer_path
      command "./issetupnx -s #{dmgr_response_path}"
      action :run
    end

    # Removing cache files
    execute "Removing cache files ..." do
      cwd Chef::Config[:file_cache_path]
      command "rm -f #{dmgr_package_file}"
      action :run
    end