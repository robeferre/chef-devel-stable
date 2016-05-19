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
   default['wsp85']['config']['mount']	=  Chef::Config[:file_cache_path] + "/wsp_85_base_install"

   default['wsp85']['config']['cache']	=  "/DST/wsp_85_base_install/unzip"
   
   # Websphere Portal
   default['wsp85']['base']['path'] = "/opt/IBM/WebSphere/Portal"
  
   default['wsp85']['zip']['file1']		= "WSP_Server_8.5_Install.zip"
  
   default['wsp85']['zip']['location1']	= "/install/CHEF_FILES/DSTSA/CONTENTMANAGMENT85/RHEL/WSP_Server_8.5_Install.zip"
 
   default['wsp85']['response']['erb']	= "wsp_85_resp.xml.erb"
   default['wsp85']['response']['file']	= "wsp_85_resp.xml"

   default['wsp85']['log']['file']		= "#{node['wsp85']['config']['cache']}/wsp_85_setup.log"

end