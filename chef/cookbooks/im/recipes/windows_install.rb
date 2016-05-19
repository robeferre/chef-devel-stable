###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
# IBM Installation Manager (Windows)
#
# Last update: 06/03/2014  - Daniel Abraão Silva Costa (dasc@br.ibm.com)
###########################################################################################################################################

Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")

package_file = Chef::Config[:file_cache_path] + "\\" + node['im']['zip']['file_name'] 
dynamic_url = "http://#{$BEST_SERVER}#{node['im']['zip']['url']}"

# Testing if the IM is already installed
if (!(File.directory?(node['im']['install']['path'])))

  # Searching for the temp files/directory - If not found it will creates
  if (!(File.exists?(node['config']['cache']['path']) && File.directory?(node['config']['cache']['path'])))
    directory node['config']['cache']['path'] do
       recursive true
       action :create
    end   
  end

  # Obtaining the installation package
  remote_file package_file do
    source dynamic_url
    not_if { ::File.exists?(package_file) }
  end

  # Unconpressing the installation package
  windows_zipfile node['config']['cache']['path'] do
      source package_file
      action :unzip
      overwrite true
  end

  # Install IM silently
  execute "Installing IM" do
    cwd node['config']['cache']['path']
    command "installc -acceptLicense"
    action :run
  end

  # Delete Installers
  execute "Removing Installers" do
    cwd node['config']['cache']['path']
    command "del /q *.* && for /d %x in (*.*) do @rd /s /q %x"
    action :run
  end

else
  log "IBM Installation manager already installed!" do
  level :info
  end
end