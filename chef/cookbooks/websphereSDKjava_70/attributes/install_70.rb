################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

   # Installation Manager
   default['im']['base']			= "/opt/IBM/InstallationManager/eclipse/tools/"
   
   # Config directory
   default['sdk70']['config']['mount']	=  Chef::Config[:file_cache_path] + "/sdk_70_base_install"

   default['sdk70']['config']['cache']	=  "/DST/sdk_70_base_install/unzip"
   
   #IHS
  
   default['sdk70']['zip']['file1']		= "WS_SDK_JAVA_TECH_7.0.6.1.zip"
 
   default['sdk70']['zip']['location']	= "/install/CHEF_FILES/DSTSA/CONTENTMANAGMENT85/RHEL/WS_SDK_JAVA_TECH_7.0.6.1.zip"
 
   default['sdk70']['response']['erb']	 = "wsdk_install_resp.txt.erb"

   default['sdk70']['response']['file'] = "wsdk_install_resp.txt"

   default['sdk70']['log']['file']		= "#{node['sdk70']['config']['cache']}/sdk_70_setup.log"

end