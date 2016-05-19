##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

module Helper_was_80

 	# This method detects previous installations 
	def package_already_installed
	  Chef::Log.info("[RECIPE STARTED] ==> Recipe:#{recipe_name} Cookbook:#{cookbook_name}")
		im_install_location = node['im']['installation']['path']
		if File.exist?("#{im_install_location}")
  	   cmd = `"#{im_install_location}/imcl" listInstalledPackages`
  	   if cmd.include? "websphere.ND.v80_8.0"
  	     Chef::Log.info("Package already installed: Websphere.ND.v80_8.0")
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
