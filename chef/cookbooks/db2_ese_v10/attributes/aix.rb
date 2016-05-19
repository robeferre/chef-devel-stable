################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##################################################################################
case node['platform_family']
when 'aix'
  #config
  default['db2']['cache'] = Chef::Config[:file_cache_path] + "/db2_install"
  
  #db2
  default['db2']['package']['file'] = "v10.1fp3_aix64_server.tar.gz"
  default['db2']['package']['url'] = "/install/AIX/MIDDLEWARE/DB2/V101/v10.1fp3_aix64_server.tar.gz"
  default['db2']['install']['cache'] = "#{node['db2']['cache']}/server/"
  default['db2']['response']['file'] = "#{node['db2']['cache']}/aix_server.rsp"
  default['db2']['main']['path'] = "/home/db2inst1/"
  default['db2']['directories']['array'] = ['/home/dasusr1', '/home/db2inst1', '/home/db2fenc1']
  default['db2']['users']['array'] = ['dasusr1', 'db2inst1', 'db2fenc1']
  default['db2']['groups']['array'] = ['dasadm1', 'db2iadm1', 'db2fadm1']
  default['db2']['users']['cmd'] = ['dasadm1 -m dasusr1', 'db2iadm1 -m db2inst1', 'db2fadm1 -m db2fenc1']
    
  default['db2']['jdbc']['file'] = "libdb2jdbc.so.1"
  default['db2']['jdbc']['link'] = "libdb2jdbc.so"
  default['db2']['jdbc']['url'] = "/install/CHEF_FILES/DB2/libdb2jdbc.so.1"
  default['db2']['jdbc']['path'] = "/home/db2inst1/sqllib/lib"
  default['db2']['jdbc']['tmpdir'] = "#{node['db2']['cache']}/tmp/db2jdbc"
    
  default['db2']['client']['package']['file'] = "v10.1fp3_aix64_rtcl.tar"
  default['db2']['client']['package']['url'] = "/install/AIX/MIDDLEWARE/DB2/V101/client/v10.1fp3_aix64_rtcl.tar"
  default['db2']['client']['response']['file'] = "#{node['db2']['client']['cache']}/db2ese_v10.rsp"
  default['db2']['client']['cache'] = Chef::Config[:file_cache_path] + "/db2_client_install"
  default['db2']['client']['bin'] = "/opt/IBM/db2/V10.1/bin/"
  default['db2']['client']['response']['file'] = "#{node['db2']['client']['cache']}/aix_client.rsp"
  default['db2']['client']['install']['cache'] = "#{node['db2']['client']['cache']}/rtcl/"
end

