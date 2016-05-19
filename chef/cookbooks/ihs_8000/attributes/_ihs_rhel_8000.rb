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
   default['ihs8000']['config']['mount']	=  Chef::Config[:file_cache_path] + "/ihs_8000_base_install"
   default['ihs8000']['config']['cache']	=  "/DST/ihs_8000_base_install/unzip"
   
   #IHS
   default['ihs8000']['base']['path']	= "/opt/IBM/HTTPServer"
  
   default['ihs8000']['zip']['file1']	= "WASV8.0_SUPPL_1_OF_4_MP_ML.zip"
   default['ihs8000']['zip']['file2']	= "WAS_V8.0_SUPPL_2_OF_4_MP_ML.zip"
   default['ihs8000']['zip']['file3']	= "WAS_V8.0_SUPPL_3_OF_4_MP_ML.zip"
   default['ihs8000']['zip']['file4']	= "WASV8.0_SUPPL_4_OF_4_MP_ML.zip"

   default['ihs8000']['zip']['location1']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/WASV8.0_SUPPL_1_OF_4_MP_ML.zip '
   default['ihs8000']['zip']['location2']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/WAS_V8.0_SUPPL_2_OF_4_MP_ML.zip '
   default['ihs8000']['zip']['location3']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/WAS_V8.0_SUPPL_3_OF_4_MP_ML.zip '
   default['ihs8000']['zip']['location4']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/LINUX/IHS/IHS_80/WASV8.0_SUPPL_4_OF_4_MP_ML.zip '


   default['ihs8000']['response']['erb']		= "ihs_8000_rhel.rsp.erb"
   default['ihs8000']['response']['file']	= "ihs_8000_rhel.rsp"

   default['ihs8000']['log']['file']	= "#{node['ihs8000']['config']['cache']}/ihs_8000_setup.log"
end