################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################

   # Config directory
	default['ihs70']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_70_base_install"

case node['platform_family']


when 'rhel'


   default['ihs70']['config']['cache']	=  "/DST/ihs_70_base_install/unzip"
   
  #######################################################
  #IHS
  #######################################################

   default['ihs70']['base']['path']		= "/opt/IBM/HTTPServer"
  
   default['ihs70']['zip']['file']		= "C1G36ML.tar.gz"

   default['ihs70']['tar']['file']		= "C1G36ML.tar"

   default['ihs70']['zip']['location1']	= "/install/CHEF_FILES/IHS_70_ND/C1G36ML.tar.gz"

   default['ihs70']['response']['erb']	 	= "ihs_70_resp.txt.erb"
   default['ihs70']['response']['file']	= "ihs_70_resp.txt"

###########################################################
# Install websphere plugins
###########################################################

  default['ihs70']['plg']['path'] = "/opt/IBM/HTTPServer/Plugins"

  default['ihs70']['plg']['respfile'] = "ihs_websphere_plg_70.txt"

  default['ihs70']['plg']['erb'] = "ihs_websphere_plg_70.txt.erb"

when 'windows'

   default['ihs70']['config']['cache']	=  'C:/DST/ihs_70_base_install/unzip'
   
  #######################################################
  #IHS
  #######################################################

   default['ihs70']['base']['path']		= 'C:/Program Files/IBM/HTTPServer'
  
   default['ihs70']['zip']['file']		= "C1G2KML.zip"


   default['ihs70']['zip']['location1']	= "/install/CHEF_FILES/IHS_70_ND/C1G2KML.zip"

   default['ihs70']['response']['erb']	 	= "ihs_70_resp.txt.erb"
   default['ihs70']['response']['file']	= "ihs_70_resp.txt"

###########################################################
# Install websphere plugins
###########################################################

  default['ihs70']['plg']['path'] = 'C:/Program Files/IBM/HTTPServer/Plugins'

  default['ihs70']['plg']['respfile'] = "ihs_websphere_plg_70.txt"

  default['ihs70']['plg']['erb'] = "ihs_websphere_plg_70.txt.erb"


end