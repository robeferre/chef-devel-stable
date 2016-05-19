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
   default['ihs8551']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_8551_base_install"
   default['ihs8551']['config']['cache']	=  "/DST/ihs_8551_base_install/unzip"
   
   #IHS
   default['ihs8551']['base']['path']	= "/opt/IBM/HTTPServer"
  
   default['ihs8551']['zip']['file1']	= "8.5.5-WS-WASSupplements-FP0000001-part1.zip"
   default['ihs8551']['zip']['file2']	= "8.5.5-WS-WASSupplements-FP0000001-part2.zip"

   default['ihs8551']['zip']['location1']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_85/8.5.5-WS-WASSupplements-FP0000001-part1.zip '
   default['ihs8551']['zip']['location2']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_85/8.5.5-WS-WASSupplements-FP0000001-part2.zip '
  
   default['ihs8551']['response']['erb']	= "ihs_8551_rhel.rsp.erb"
   default['ihs8551']['response']['file']	= "ihs_8551_rhel.rsp"

   default['ihs8551']['log']['file']	= "#{node['ihs8551']['config']['cache']}/ihs_8551_setup.log"
end