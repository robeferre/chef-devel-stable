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

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

package_file = Chef::Config[:file_cache_path] + "/" + node['im']['zip']['file']
install_log_path = Chef::Config[:file_cache_path] + "/im_silent_install.log"
im_shared_dir = node['im']['shared_dir']
dynamic_url = "http://#{$BEST_SERVER}#{node['im']['zip']['url']}"

# Testing if the IM is already installed
if (!(File.directory?(node['im']['install']['path'])))
  
  # Clean up the cache dir
  execute "Cleaning up the Cache Path" do
    user "root"
    cwd Chef::Config[:file_cache_path]
    command "rm -rf *"
    action :run
  end

  # Create directory for config cache
  if (!(File.directory?(node['im']['shared_dir'])))
    directory node['im']['shared_dir'] do
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
  if (!(File.directory?(node['im']['shared_dir'])))
    execute "Unzip IM File" do
      user "root"
      cwd node['im']['shared_dir']
      command "unzip -o #{package_file} -d #{im_shared_dir}"
      action :run
    end
  end
  
  # Install IM silently
  execute "Installing IM" do
    user "root"
    cwd node['im']['shared_dir']
    command "#{node['im']['shared_dir']}/installc -sVP -acceptlicense -log #{install_log_path}"
    action :run
  end
  
else
  log "IBM Installation manager is already installed!" do
  level :info
  end
end
