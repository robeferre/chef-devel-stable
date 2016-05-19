################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['tdsfp24']['config']['mount']	=  Chef::Config[:file_cache_path] + "/tds_63FP24_base_install"

   default['tdsfp24']['config']['cache']	=  "/DST/tds_63FP24_base_install/unzip"
   
   default['tdsfp24']['zip']['file']		= "6.3.0.24-ISS-ITDS-LinuxX64-FP0024.tar.gz"
  
   default['tdsfp24']['tar']['file']		= "6.3.0.24-ISS-ITDS-LinuxX64-FP0024.tar"

   default['tdsfp24']['base_install']		= "/opt/IBM/ldap"

   default['tdsfp24']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/6.3.0.24-ISS-ITDS-LinuxX64-FP0024.tar.gz"
 
   default['tdsfp24']['base']['path'] = "/DST/tds_63FP24_base_install/unzip/6.3.0.24-ISS-ITDS-LinuxX64-FP0024"
  
end