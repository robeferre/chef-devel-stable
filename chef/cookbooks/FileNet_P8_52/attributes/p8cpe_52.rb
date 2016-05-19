################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8cpe']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8cpe_52_base_install"

   default['p8cpe']['config']['cache']	=  "/DST/p8cpe_52_base_install/unzip"
   
   default['p8cpe']['zip']['file']		= "FN_CE_5.2_LINUX_ML.tar.gz"

   default['p8cpe']['tar']['file']		= "FN_CE_5.2_LINUX_ML.tar"
  
   default['p8cpe']['base_install']		= "/opt/IBM/FileNet/ContentEngine"

   default['p8cpe']['config']['cache']		= "/opt/IBM/FileNet/ContentEngine/tools/configure"
  
   default['p8cpe']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/FN_CE_5.2_LINUX_ML.tar.gz"

   default['p8cpe']['install']['file'] = "5.2.0-P8CE-LINUX.BIN"
 
   default['p8cpe']['response']['erb']	= "ce_silent_install.txt.erb"
   default['p8cpe']['response']['file']	= "ce_silent_install.txt"
  
end