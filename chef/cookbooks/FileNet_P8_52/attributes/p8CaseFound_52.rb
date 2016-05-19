################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8casefound']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8casefound_52_base_install"

   default['p8casefound']['config']['cache']	=  "/DST/p8casefound_52_base_install/unzip"
   
   default['p8casefound']['zip']['file']		= "IBM_CASE_FOUNDATION_V5.2_LNX_ML.tar.gz"

   default['p8casefound']['tar']['file']		= "IBM_CASE_FOUNDATION_V5.2_LNX_ML.tar"
  
   default['p8casefound']['base_install']		= " /opt/IBM/FileNet/CaseFoundation"

   default['p8casefound']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/IBM_CASE_FOUNDATION_V5.2_LNX_ML.tar.gz"

   default['p8casefound']['install']['file'] = "5.2.0-P8CaseFoundation-LINUX.BIN"
 
   default['p8casefound']['response']['erb']	= "CaseFoundation_silent_install.txt.erb"
   default['p8casefound']['response']['file']	= "CaseFoundation_silent_install.txt"
  
end