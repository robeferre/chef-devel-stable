##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Daniel Abraao Silva Costa
# Contact: dasc@br.ibm.com
#
##########################################################################################################

module InstallationCheck

	# This method detects previous installations 
  def checkInstalledPackages
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_location_path = node['was8502']['im_tools_path']
      if File.exist?("#{im_location_path}")
        installedPackagesList = `"#{im_location_path}/imcl" listInstalledPackages`
        if installedPackagesList.include? "websphere.ND.v85_8.5.0002"
          Chef::Log.info("Package is already installed: Websphere.ND.v85_8.5.0002")
          imIsInstalled = true
        else 
          imIsInstalled = false
        end
      else
        Chef::Log.info("The IBM Installation Manager wasn't found.")
        imIsInstalled = false
      end   
      # Return    
    imIsInstalled
  end

end
