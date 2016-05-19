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
   default['ihs8502']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_8502_base_install"
   default['ihs8502']['config']['cache']	=  "/DST/ihs_8502_base_install/unzip"
   
   #IHS
   default['ihs8502']['base']['path']		= "/opt/IBM/HTTPServer"
  
   default['ihs8502']['zip']['file1']		= "8.5.0-WS-WASSupplements-FP0000002-part1.zip"
   default['ihs8502']['zip']['file2']		= "8.5.0-WS-WASSupplements-FP0000002-part2.zip"

   default['ihs8502']['zip']['location1']	= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WASSupplements-FP0000002-part1.zip"
   default['ihs8502']['zip']['location2']	= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WASSupplements-FP0000002-part2.zip"
  
   default['ihs8502']['response']['erb']	= "ihs_8502_rhel.rsp.erb"
   default['ihs8502']['response']['file']	= "ihs_8502_rhel.rsp"

   default['ihs8502']['log']['file']		= "#{node['ihs8502']['config']['cache']}/ihs_8502_setup.log"
  
end