################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################

# Config directory
   default['ihs70027']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_70027_base_install"


case node['platform_family']

when 'rhel'

###########################################################
# UpdateInstaller (needed for install fix Pack)
###########################################################

default['ihs70027']['updateinst']['cache']	=  "/DST/ihs_70_base_install/unzip"

default['ihs70027']['updateinst']['path'] = "/opt/IBM/WebSphere/UpdateInstaller"

default['ihs70027']['updateinst']['respfile'] = "updiinstaller_70.txt"

default['ihs70027']['updateinst']['erb'] = "updiinstaller_70.txt.erb"

###########################################################
# Install IHS FP0000027
###########################################################

   default['ihs70027']['config']['cache']	=  "/DST/ihs_70027_base_install/unzip"

   default['ihs70027']['base']['path']		= "/opt/IBM/HTTPServer"
  
   default['ihs70027']['fixpack27']['location']	               = "/install/CHEF_FILES/IHS_70_ND/FixPack/7.0.0-WS-IHS-LinuxX64-FP0000027.pak"
  
   default['ihs70027']['fixpack27']['file']	= "7.0.0-WS-IHS-LinuxX64-FP0000027.pak"

   default['ihs70027']['response']['erb']	= "ihs_70027.txt.erb"
   default['ihs70027']['response']['file']	= "ihs_70027.txt"

###########################################################
# Install Websphere plugin for IHS FP0000027
###########################################################

 default['ihs70027']['plg']['path'] = "/opt/IBM/HTTPServer/Plugins"

   default['ihs70027']['plg_fixpack27']['location']	               = "/install/CHEF_FILES/IHS_70_ND/FixPack/7.0.0-WS-PLG-LinuxX64-FP0000027.pak"

default['ihs70027']['plg_fixpack27']['file']	= "7.0.0-WS-PLG-LinuxX64-FP0000027.pak"

  default['ihs70027']['plg_resp']['file'] = "plg_ihs_70027.txt"

  default['ihs70027']['plg_resp']['erb'] = "plg_ihs_70027.txt.erb"

when 'windows'

###########################################################
# UpdateInstaller (needed for install fix Pack)
###########################################################

default['ihs70027']['updateinst']['cache']	=  'C:/DST/ihs_70_base_install/unzip'

default['ihs70027']['updateinst']['path'] = 'C:/Program Files/IBM/WebSphere/UpdateInstaller'

default['ihs70027']['updateinst']['respfile'] = "updiinstaller_70.txt"

default['ihs70027']['updateinst']['erb'] = "updiinstaller_70.txt.erb"

###########################################################
# Install IHS FP0000027
###########################################################

   default['ihs70027']['config']['cache']	=  'C:/DST/ihs_70027_base_install/unzip'

   default['ihs70027']['base']['path']		= 'C:/Program Files/IBM/HTTPServer'
  
   default['ihs70027']['fixpack27']['location']	               = "/install/CHEF_FILES/IHS_70_ND/FixPack/7.0.0-WS-IHS-WinX64-FP0000027.pak"
  
   default['ihs70027']['fixpack27']['file']	= "7.0.0-WS-IHS-WinX64-FP0000027.pak"

   default['ihs70027']['response']['erb']	= "ihs_70027.txt.erb"
   default['ihs70027']['response']['file']	= "ihs_70027.txt"

###########################################################
# Install Websphere plugin for IHS FP0000027
###########################################################

 default['ihs70027']['plg']['path'] = 'C:/Program Files/IBM/HTTPServer/Plugins'

   default['ihs70027']['plg_fixpack27']['location']	               = "/install/CHEF_FILES/IHS_70_ND/FixPack/7.0.0-WS-PLG-WinX64-FP0000027.pak"

default['ihs70027']['plg_fixpack27']['file']	= "7.0.0-WS-PLG-WinX64-FP0000027.pak"

  default['ihs70027']['plg_resp']['file'] = "plg_ihs_70027.txt"

  default['ihs70027']['plg_resp']['erb'] = "plg_ihs_70027.txt.erb"

 
end