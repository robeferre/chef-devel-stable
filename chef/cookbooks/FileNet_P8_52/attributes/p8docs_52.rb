################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8docs']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8docs_52_base_install"

   default['p8docs']['config']['cache']	=  "/DST/p8docs_52_base_install/unzip"
   
   default['p8docs']['zip']['file']		= "P8_PLATFORM_V5.2_MP_ML.zip"
  
   default['p8docs']['base_install']		= "/opt/IBM/P8InfoCenter"

   default['p8docs']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/P8_PLATFORM_V5.2_MP_ML.zip"
 
   default['p8docs']['installfile']['path'] = "/DST/p8docs_52_base_install/unzip/DocInstaller.LINUX"

   default['p8docs']['install']['file'] = "5.2.0-P8IC-LINUX.BIN"

   default['p8docs']['response']['erb']	= "p8ic_silent_install.txt.erb"
   default['p8docs']['response']['file']	= "p8ic_silent_install.txt"
  
end