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
   default['ihs8550']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_8550_base_install"
   default['ihs8550']['config']['cache']	=  "/DST/ihs_8550_base_install/unzip"
   
   #IHS
   default['ihs8550']['base']['path']	= "/opt/IBM/HTTPServer"
  
   default['ihs8550']['zip']['file1']	= "WAS_V8.5.5_SUPPL_1_OF_3.zip"
   default['ihs8550']['zip']['file2']	= "WAS_V8.5.5_SUPPL_2_OF_3.zip"
   default['ihs8550']['zip']['file3']	= "WAS_V8.5.5_SUPPL_3_OF_3.zip"

   default['ihs8550']['zip']['location1']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_85/WAS_V8.5.5_SUPPL_1_OF_3.zip '
   default['ihs8550']['zip']['location2']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_85/WAS_V8.5.5_SUPPL_2_OF_3.zip '
   default['ihs8550']['zip']['location3']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_85/WAS_V8.5.5_SUPPL_3_OF_3.zip '

   default['ihs8550']['response']['erb']	= "ihs_8550_rhel.rsp.erb"
   default['ihs8550']['response']['file']	= "ihs_8550_rhel.rsp"

   default['ihs8550']['log']['file']	= "#{node['ihs8550']['config']['cache']}/ihs_8550_setup.log"
end