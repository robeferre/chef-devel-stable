################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['tds']['config']['mount']	=  Chef::Config[:file_cache_path] + "/tds_63_base_install"

   default['tds']['config']['cache']	=  "/DST/tds_63_base_install/unzip"
   
   default['tds']['zip']['file']		= "tds63-linux-x86-64-base.tar"
  
   default['tds']['base_install']		= "/opt/IBM/ldap"

   default['tds']['zip']['location']	= "/install/CHEF_FILES/DSTSA/FILENET_P8_52/RHEL/tds63-linux-x86-64-base.tar"
 
   default['tds']['base']['path'] = "/DST/tds_63_base_install/unzip/tdsV6.3/tdsfiles"
  
end