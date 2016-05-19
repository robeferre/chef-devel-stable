##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################


module Helper_was_ND_8000

	# This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base']['path']
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "websphere.ND.v80"
       Chef::Log.info("Package already installed: Websphere.ND.v80")
       found=true
     else 
      if cmd.include? "websphere.ND.v85"
       Chef::Log.info("Package already installed: Websphere.ND.v85")
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


module Helper_BPM_8000

	# This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base']['path']
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "bpm.ADV.V80"
       Chef::Log.info("Package already installed: bpm.ADV.V80")
       found=true
     else 
      found=false
     end
    else
     found=false
    end   
  found
  end

end

module Helper_dbexpress_9704

	# This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    im_install_location = node['im']['base']['path']
    if File.exist?("#{im_install_location}")
     cmd = `"#{im_install_location}/imcl" listInstalledPackages`
     if cmd.include? "ws.DB2EXP97"
       Chef::Log.info("Package already installed: ws.DB2EXP97")
       found=true
     else 
      found=false
     end
    else
     found=false
    end   
  found
  end

end



