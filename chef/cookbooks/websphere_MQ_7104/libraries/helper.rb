##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#########################################################################################################

module Helper_mq7104

 	 	# This method detects previous installations 
	def package_already_installed
	   mq_install_location = node['mq7104']['base']['path']
	    Chef::Log.info("mq_install_location #{mq_install_location}")
	 if File.exist?("#{mq_install_location}")
	     cmd = `"#{mq_install_location}/bin/dspmqver" -f 2`
	   if cmd.include? "7.1.0.4"
	       Chef::Log.info("Package MQ already installed:'#{cmd}'")
	       found=true
	     else 
		if cmd.include? "7.1.0.3"
		   Chef::Log.info("Package installed:'#{cmd}'")
	           found=false
		else 
		Chef::Log.info("another version is installed: '#{cmd}'")
		found=true 
		end
	     end
	   else
	    found=false
	  end   
	found
	end
end