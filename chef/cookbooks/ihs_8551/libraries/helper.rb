##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
#
##########################################################################################################

module Helper_ihs8551

  # This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base'] 
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "websphere.IHS.v85_8.5.5001"
       Chef::Log.info("Package already installed: websphere.IHS.v85_8.5.5001")
       found=true
     else 
	if cmd.include? "websphere.IHS.v80" 
	  Chef::Log.info("Package already installed: websphere.IHS.v80")
	  found=true
	else
	  found=false
	end
     end
    else
     found=false
    end   
  found
  end

end
