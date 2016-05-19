#==================================================================================================
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#==================================================================================================
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#==================================================================================================

module Helper_was_70

 	# This method detects previous installations 
	def package_already_installed
	    	    
	    platform_family=node['platform_family']
	    if platform_family == "rhel"
        version_info = 'cd /opt/IBM/WebSphere/AppServer/bin/ && ./versionInfo.sh'
      elsif platform_family == "windows"
        version_info = "cd C:\\Program Files\\IBM\\WebSphere\\AppServer\\bin\\ && versionInfo.bat"
      end
		  cmd = `#{version_info}`
		  
		  if cmd.include? "7.0.0.27"
		  Chef::Log.info("Package already installed: Websphere.ND.v7.0.0.27")
        found=true
        else
        found=false
      end
   found
  end

end
