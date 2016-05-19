################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

     
   # Config directory
   default['cognos102']['config']['mount']	=  Chef::Config[:file_cache_path] + "/cognos_tm1_102_base_install"

   default['cognos102']['config']['cache']	=  "/DST/cognos_tm1_102_base_install/unzip"

default['cognos102']['install']['cache']	=  "/DST/cognos_tm1_102_base_install/unzip/linuxi38664h" 
    
   default['cognos102']['base_install'] = "/opt/ibm/cognos/tm1_64"

   default['cognos102']['zip']['file1'] = "tm1_10.2_l86-64_ml.tar.gz"

   default['cognos102']['zip']['tarfile1'] = "tm1_10.2_l86-64_ml.tar"
 
   default['cognos102']['zip']['location1']	= "/install/CHEF_FILES/DSTSA/Cognos_tm1_102/tm1_10.2_l86-64_ml.tar.gz"
 
   default['cognos102']['resp']['erb'] = "cognos_tm1_102_respfile.ats.erb"

   default['cognos102']['resp']['ats'] = "cognos_tm1_102_respfile.ats"


end