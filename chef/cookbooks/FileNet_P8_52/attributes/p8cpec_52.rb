################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8cpec']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8cpec_52_base_install"

   default['p8cpec']['config']['cache']	=  "/DST/p8cpec_52_base_install/unzip"
   
   default['p8cpec']['zip']['file']		= "FN_CEC_5.2_LINUX_EN.tar.gz"

   default['p8cpec']['tar']['file']		= "FN_CEC_5.2_LINUX_EN.tar"
 
   default['p8cpec']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/FN_CEC_5.2_LINUX_EN.tar.gz"

   default['p8cpec']['install']['file'] = "5.2.0-P8CE-CLIENT-LINUX.BIN"
 
default['p8cpec']['base_install']		= "/opt/IBM/FileNet/CEClient"
 
   default['p8cpec']['response']['erb']	= "ceclient_silent_install.txt.erb"
   default['p8cpec']['response']['file']	= "ceclient_silent_install.txt"
  
end