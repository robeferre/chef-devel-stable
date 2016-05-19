# Config directory
default['mqc7104']['config']['mount']	=  Chef::Config[:file_cache_path] + "/mq7104_clt_base_install"


case node['platform_family']

when 'rhel'
 
   default['mqc7104']['base']['path']		= "/opt/mqm"
   default['mqc7104']['config']['cache']	=  "/DST/mq7104_clt_base_install/unzip"

   default['mqc7104']['zip']['file1']		= "mqc71_7.1.0.4_linuxx86-64.tar.gz"
   default['mqc7104']['zip']['tarfile']		= "mqc71_7.1.0.4_linuxx86-64.tar"
  
   default['mqc7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/mqc71_7.1.0.4_linuxx86-64.tar.gz"
  
when 'aix'
   
   default['mqc7104']['base']['path']		= "/usr/mqm"
   default['mqc7104']['config']['cache']	=  "/DST/mq7104_clt_base_install/unzip"

   default['mqc7104']['zip']['file1']		= "mqc71_7.1.0.4_aix.tar.Z"
   default['mqc7104']['zip']['tarfile']		= "mqc71_7.1.0.4_aix.tar"
  
   default['mqc7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/mqc71_7.1.0.4_aix.tar.Z"
  
  
when 'windows'

   default['mqc7104']['base']['path']		= "C:/mqm"

   default['mqc7104']['install']['path']	= 'C:/mqm/source/WebSphere MQ 7.1.0.4'
   default['mqc7104']['config']['cache']	= "C:/DST/mq7104_clt_base_install/unzip"
  

   default['mqc7104']['zip']['file1']		= "mqc71_7.1.0.4_win.zip"
   default['mqc7104']['exec']['file']		= "C:/DST/mq7104_clt_base_install/unzip/Windows/MSI/IBM WebSphere MQ.msi"
   default['mqc7104']['resp']['file']		= "mq7104_silent_install.resp"
   default['mqc7104']['resp']['erb']		= "mq7104_silent_install.resp.erb"
      
   default['mqc7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/mqc71_7.1.0.4_win.zip"
  
end