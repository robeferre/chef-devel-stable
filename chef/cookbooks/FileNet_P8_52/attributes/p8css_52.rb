################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8css']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8css_52_base_install"

   default['p8css']['config']['cache']	=  "/DST/p8css_52_base_install/unzip"
   
   default['p8css']['zip']['file']		= "FN_CSS_5.2_LINUX_64_ML.tar.gz"

   default['p8css']['tar']['file']		= "FN_CSS_5.2_LINUX_64_ML.tar"
  

   default['p8css']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/FN_CSS_5.2_LINUX_64_ML.tar.gz"

   default['p8css']['install']['file'] = "5.2.0-CSS-LINUX64.bin"
 
    default['p8css']['base_install']		= "/opt/IBM/ContentSearchServices"


   default['p8css']['response']['erb']	= "css_silent_install.txt.erb"
   default['p8css']['response']['file']	= "css_silent_install.txt"
  
end