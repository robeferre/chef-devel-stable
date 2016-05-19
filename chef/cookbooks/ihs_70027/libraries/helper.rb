##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
#
##########################################################################################################

module Helper_ihs70027

  # This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    ihs_install_location = node['ihs70027']['base']['path']
    if File.exist?("#{ihs_install_location}")
	cmd=`cat #{ihs_install_location}/version.signature`
	Chef::Log.info("cmd #{cmd}")
	 if cmd.include? "IBM HTTP Server 7.0.0.27"
       Chef::Log.info("Package already installed: IBM HTTP Server 7.0.0.27")
       found=false
      else 
	  found=true
	 end
     end
      found
  end

end


module Helper_plg70027

  # This method detects previous installations 
  def package_already_installed
    Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
    ihs_install_location = node['ihs70027']['base']['path']
    if File.exist?("#{ihs_install_location}")
	cmd=`/opt/IBM/HTTPServer/Plugins/bin/versionInfo.sh |grep Version`
	 if cmd.include? "Version 7.0.0.27"
       Chef::Log.info("Package already installed: IBM HTTP Server 7.0.0.27")
       found=false
      else 
	Chef::Log.info("Package ready for install")
	  found=true
	 end
     end
      found
  end

end
