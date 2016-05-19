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
   default['ihs850']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_850_base_install"
   default['ihs850']['config']['cache']	=  "/DST/ihs_850_base_install/unzip"
   
   #IHS
   default['ihs850']['base']['path']		= "/opt/IBM/HTTPServer"
  
   default['ihs850']['zip']['file1']		= "WAS_V85_SUPPL_1_OF_3.zip"
   default['ihs850']['zip']['file2']		= "WAS_V85_SUPPL_2_OF_3.zip"
   default['ihs850']['zip']['file3']		= "WAS_V85_SUPPL_3_OF_3.zip"

   default['ihs850']['zip']['location1']	= "/install/CHEF_FILES/IHS_85/WAS_V85_SUPPL_1_OF_3.zip"
   default['ihs850']['zip']['location2']	= "/install/CHEF_FILES/IHS_85/WAS_V85_SUPPL_2_OF_3.zip"
   default['ihs850']['zip']['location3']	= "/install/CHEF_FILES/IHS_85/WAS_V85_SUPPL_3_OF_3.zip"

   default['ihs850']['response']['erb']	= "ihs_850_rhel.rsp.erb"
   default['ihs850']['response']['file']	= "ihs_850_rhel.rsp"

   default['ihs850']['log']['file']		= "#{node['ihs850']['config']['cache']}/ihs_850_setup.log"

end