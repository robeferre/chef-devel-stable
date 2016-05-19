################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
case node['platform_family']
when 'rhel'

  
   # Config directory
   default['p8db']['config']['mount']	=  Chef::Config[:file_cache_path] + "/p8db_52_base_install"

   default['p8db']['cache']	=  "/DST/p8db_52_base_install/unzip"
   
 
   default['p8db']['db2_home']		= "/home/db2inst1/"
   default['p8db']['db2_user']  		= "db2inst1"
   default['p8db']['db2_pass']       	= "db2inst1"

   default['p8db']['rspdb']['erb']	= "create_db_db2.sql.erb"
   default['p8db']['rspdb']['file']	= "create_db_db2.sql"
   default['p8db']['rspts']['erb']	= "create_ts_db2.sql.erb"
   default['p8db']['rspts']['file']	= "create_ts_db2.sql"
  
end