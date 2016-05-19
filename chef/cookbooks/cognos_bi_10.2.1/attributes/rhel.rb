################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'
   # Cognos BI
   default['cognos1021']['config']['mount']	=  Chef::Config[:file_cache_path] + "/cognos_bi_1021_base_install"
   default['cognos1021']['config']['cache']	=  "/DST/cognos_bi_1021_base_install/unzip"
   default['cognos1021']['install']['cache'] =  "/DST/cognos_bi_1021_base_install/unzip/linuxi38664h"  
   default['cognos1021']['base_install'] = "/opt/ibm/cognos/c10_64"
   
   default['cognos1021']['zip']['file1'] = "bi_svr_10.2.1_l86_ml.tar.gz"
   default['cognos1021']['zip']['tarfile1']= "bi_svr_10.2.1_l86_ml.tar"
   default['cognos1021']['zip']['location1'] = "/install/CHEF_FILES/DSTSA/Cognos_BI_1021/bi_svr_10.2.1_l86_ml.tar.gz"
   
   default['cognos1021']['resp']['erb'] = "cognos_bi_1021_respfile.ats.erb"
   default['cognos1021']['resp']['ats'] = "cognos_bi_1021_respfile.ats"

   default['cognos1021']['db2_client']['jdbc_path'] = "/opt/IBM/db2/V10.1/java"

   # Cognos Samples
   default['cognos1021']['smps']['cache_path']	=  "/DST/cognos_bi_smps_1021"
   default['cognos1021']['smps']['pkg_file'] = "bi_smps_10.2.1_mp_ml.tar.gz"
   default['cognos1021']['smps']['url']	= "/install/CHEF_FILES/DSTSA/Cognos_BI_1021/bi_smps_10.2.1_mp_ml.tar.gz"
   default['cognos1021']['smps']['root_path']   = "/opt/ibm/cognos/c10_64/webcontent/samples/datasources"
   default['cognos1021']['smps']['db2_datasource']  = "/opt/ibm/cognos/c10_64/webcontent/samples/datasources/db2"
   default['cognos1021']['smps']['datasource_file'] = "GS_DB.tar.gz"

   # Cognos Data Manager Module
   default['cognos1021']['dmgr']['cache_path']  =  "/DST/cognos_bi_dmgr_1021"
   default['cognos1021']['dmgr']['pkg_file'] = "bi_dmgr_10.2.1_l86_en.tar.gz"
   default['cognos1021']['dmgr']['url']   = "/install/CHEF_FILES/DSTSA/Cognos_BI_1021/bi_dmgr_10.2.1_l86_en.tar.gz"

   #IHS 
   default['cognos1021']['ihs']['base_path'] = "/opt/IBM/HTTPServer"
   default['cognos1021']['ihs']['conf_path'] = "/opt/IBM/HTTPServer/conf"

   #Netezza
   default['cognos1021']['netezza']['client_url'] = "/install/CHEF_FILES/DSTSA/NETEZZA/NCC_V7.1_LINUX_EN.tar.gz"
   default['cognos1021']['netezza']['pkg_file'] = "NCC_V7.1_LINUX_EN.tar.gz"
   default['cognos1021']['netezza']['cache_dir']  =  Chef::Config[:file_cache_path] + "/nztools"
   default['cognos1021']['netezza']['odbc_ini']  =  "/root/.odbc.ini"
   default['cognos1021']['netezza']['odbcinst_ini']  =  "/root/.odbcinst.ini"
end