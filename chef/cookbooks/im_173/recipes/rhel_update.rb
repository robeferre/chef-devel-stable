###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Author:  Daniel Abraão Silva Costa
# Contact: dasc@br.ibm.com
#
# IBM Installation Manager
#
###########################################################################################################################################

include_recipe 'ibm_network_handler'

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

package_file = Chef::Config[:file_cache_path] + "/" + node['im_173']['zip']['file']
install_log_path = Chef::Config[:file_cache_path] + "/im_silent_update.log"
im_shared_dir = node['im_173']['shared_dir']
ibm_shared_dir = node['im_173']['ibm_shared_dir']
dynamic_url = "http://#{$BEST_SERVER}#{node['im_173']['zip']['url']}"


# Clean up IMShared dir
  execute "Cleaning up /opt/IBM/IMShared dir ..." do
    user "root"
    command "rm -rf #{ibm_shared_dir}"
    action :run
    only_if "ls -lhar #{ibm_shared_dir}"
  end

  # Create directory for config cache
  if (!(File.directory?(node['im_173']['shared_dir'])))
    directory node['im_173']['shared_dir'] do
       owner "root"
       group "root"
       mode "0755"
       recursive true
       action :create
    end   
  end
  
  # ReCreate directory IMShared
  if (!(File.directory?(node['im_173']['ibm_shared_dir'])))
    directory node['im_173']['ibm_shared_dir'] do
       owner "root"
       group "root"
       mode "0755"
       recursive true
       action :create
    end   
  end

  # Get the IM zip file
  remote_file package_file do
    source dynamic_url
    mode "0644"
    not_if { ::File.exists?(package_file) }
  end
  
  # Unzip the IM zip file
  execute "Unzip IM File" do
    user "root"
    cwd node['im_173']['shared_dir']
    command "unzip -o #{package_file} -d #{im_shared_dir}"
    action :run
  end

  
  # Update IM silently
  execute "Updating IM ..." do
    user "root"
    cwd node['im_173']['shared_dir']
    command "#{node['im_173']['shared_dir']}/installc -sVP -acceptlicense -log #{install_log_path}"
    action :run
  end