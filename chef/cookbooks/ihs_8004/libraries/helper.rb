##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
#
##########################################################################################################

module Helper_ihs8004

  # This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base'] 
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "websphere.IHS.v80_8.0.4"
       Chef::Log.info("Package already installed: websphere.IHS.v80_8.0.4")
       found=true
     else 
	if cmd.include? "websphere.IHS.v85" 
	  Chef::Log.info("Package already installed: websphere.IHS.v85")
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
