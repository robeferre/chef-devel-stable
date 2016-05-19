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
   default['wcm85']['config']['mount']	=  Chef::Config[:file_cache_path] + "/wcm_85_base_install"

   default['wcm85']['config']['cache']	=  "/DST/wcm_85_base_install/unzip"
   
   # Web Content Manager
   default['wcm85']['base']['path'] 	    = "/opt/IBM/WebSphere/Portal"
  
   default['wcm85']['zip']['file1']		= "WCM_8.5_Install.zip"
  
   default['wcm85']['zip']['location1']	= "/install/CHEF_FILES/DSTSA/CONTENTMANAGMENT85/RHEL/WCM_8.5_Install.zip"
 
   default['wcm85']['response']['erb']	= "wcm_85_resp.xml.erb"
   default['wcm85']['response']['file']	= "wcm_85_resp.xml"
   default['wcm85']['log']['file']		= "#{node['wcm85']['config']['cache']}/wcm_85_setup.log"

end