##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
#
##########################################################################################################

module Helper_was_nd_8007

  # This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base']['path']
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "websphere.ND.v80_8.0.7" 
       Chef::Log.info("Package installed:'#{cmd}'")
       found=false
	 else
       found=true
        Chef::Log.info("Package installed:'#{cmd}'")
	end
    else
     found=true
	 Chef::Log.info("no package Package installed:'#{cmd}'")
    end   
  found
  end

end

module Helper_bpm_80

  # This method detects previous installations 
  def bpm_installation_directory
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base']['path']
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstallationDirectories`
     if (cmd.include? "BPM\V8.0" )
       Chef::Log.info("Installation Directory:'#{cmd}'")
       found=false
     else 
       found=true
     end
    else
     found=true
    end   
  found
  end

end

