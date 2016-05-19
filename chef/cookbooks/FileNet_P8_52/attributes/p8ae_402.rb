################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8ae']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8ae_402_base_install"

   default['p8ae']['config']['cache']	=  "/DST/p8ae_402_base_install/unzip"
   
   default['p8ae']['zip']['file']		= "P8_APPLICATION_ENGINE_4.0.2_ML.tar.gz"

   default['p8ae']['tar']['file']		= "P8_APPLICATION_ENGINE_4.0.2_ML.tar"
  
   default['p8ae']['base_install']		= "/opt/FileNet/AE"


   default['p8ae']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/P8_APPLICATION_ENGINE_4.0.2_ML.tar.gz"

   default['p8ae']['install']['file'] = "P8AE-4.0.2.0-LINUX.bin"
 
   default['p8ae']['response']['erb']	= "ae_silent_install.txt.erb"
   default['p8ae']['response']['file']	= "ae_silent_install.txt"
  
end