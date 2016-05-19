##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
##########################################################################################################

module Helper_wasl_855

  # This method detects previous installations 
  def package_already_installed
    im_install_location = node['im']['installation']['path']
    if File.exist?("#{im_install_location}/imcl")
        cmd=`#{im_install_location}/imcl listInstalledPackages`
        if cmd.include? "websphere.liberty.v85_8.5.5"
            Chef::Log.info("Package already installed: Websphere.liberty.v85_8.5.5")
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