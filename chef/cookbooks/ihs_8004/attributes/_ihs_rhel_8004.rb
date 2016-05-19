################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

   # Installation Manager
   default['im']['base'] = "/opt/IBM/InstallationManager/eclipse/tools/"
   
   # Config directory
   default['ihs8004']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_8004_base_install"
   default['ihs8004']['config']['cache']	=  "/DST/ihs_8004_base_install/unzip"
   
   #IHS
   default['ihs8004']['base']['path']	= "/opt/IBM/HTTPServer"
  
   default['ihs8004']['zip']['file1']	= "8.0.0-WS-WASSupplements-FP0000004-part1.zip"
   default['ihs8004']['zip']['file2']	= "8.0.0-WS-WASSupplements-FP0000004-part2.zip"

   default['ihs8004']['zip']['location1']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/8.0.0-WS-WASSupplements-FP0000004-part1.zip '
   default['ihs8004']['zip']['location2']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/8.0.0-WS-WASSupplements-FP0000004-part2.zip '
  
   default['ihs8004']['response']['erb']	= "ihs_8004_rhel.rsp.erb"
   default['ihs8004']['response']['file']	= "ihs_8004_rhel.rsp"

   default['ihs8004']['log']['file']	= "#{node['ihs8004']['config']['cache']}/ihs_8004_setup.log"
end