#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# IBM Cognos BI Sample Data V10.2.1 for Linux
#
#################################################################
smps_package_file = Chef::Config[:file_cache_path] + "/" + node['cognos1021']['smps']['pkg_file']

smps_dynamic_url = "http://#{$BEST_SERVER}#{node['cognos1021']['smps']['url']}"
smps_response_path = node['cognos1021']['smps']['cache_path'] + "/cognos_bi_smps_1021_respfile.ats"
smps_installer_path = node['cognos1021']['smps']['cache_path'] + "/linuxi38664h"

if (!(File.directory?(node['cognos1021']['smps']['root_path'])))

	# Create Cognos temporary dir
	log "Creating Cognos SMPS cache dir ..."
	directory node['cognos1021']['smps']['cache_path'] do
	  owner "root"
	  group "root"
	  mode "0755"
	  action :create
	  recursive true
	end   
  
	log "Downloading Cognos BI v10.2.1 SMPS ..." 
	remote_file smps_package_file do
	  source smps_dynamic_url
	  action :create_if_missing
	end

	# Uncompressing the installation files
	execute "Uncompressing the Cognos BI Samples ..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xvf #{smps_package_file} -C #{node['cognos1021']['smps']['cache_path']}"
	  action :run
	end

    # Create response file
	template smps_response_path do
		source "cognos_bi_smps_1021_respfile.ats.erb"	
		owner 'root'
		group 'root'
		mode '0600'
		action :touch
	end

	# Installing IBM Cognos BI Sample
    execute "Installing Cognos BI 10.2.1 Samples Data ..." do
      cwd smps_installer_path
      command "./issetupnx -s #{smps_response_path}"
      action :run
    end

    # Copy Samples Data to Deployment
    execute "Copying IBM_Cognos_Samples.zip  to deployment ..." do
      cwd smps_installer_path
      command "cp /opt/ibm/cognos/c10_64/webcontent/samples/content/IBM_Cognos_Samples.zip /opt/ibm/cognos/c10_64/deployment/"
      only_if "ls -lhar /opt/ibm/cognos/c10_64/deployment/"
      action :run
    end

    # Removing cache files
    execute "Removing cache files ..." do
      cwd Chef::Config[:file_cache_path]
      command "rm -f #{smps_package_file}"
      action :run
    end

 else
  log "Cognos BI Samples to 10.2.1 is already installed on this machine." do
  level :info
  end
end