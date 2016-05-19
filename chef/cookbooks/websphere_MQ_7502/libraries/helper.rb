##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#########################################################################################################

module Helper_mq7502

 	# This method detects previous installations 
	def package_already_installed
	   mq_install_location = node['mq7503']['base']['path']
	   Chef::Log.info("mq_install_location #{mq_install_location}")
	   if File.exist?("#{mq_install_location}")
	     cmd = `"#{mq_install_location}/bin/dspmqver" -f 2`
	     if cmd.include? "7.5.0.2"
	        Chef::Log.info("Package MQ already installed:'#{cmd}'")
	        found=true
	     else
	        Chef::Log.info("Package MQ '#{cmd}' already installed.")
	        found=true
	     end
	   else 
	     found=false
	   end
	   found
	end
end
