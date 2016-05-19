# Config directory
default['mqc7503']['config']['mount']	=  Chef::Config[:file_cache_path] + "/mq7503_clt_base_install"


case node['platform_family']

when 'rhel'
 
   default['mqc7503']['base']['path']		= "/opt/mqm"
   default['mqc7503']['config']['cache']	=  "/DST/mq7503_clt_base_install/unzip"

   default['mqc7503']['zip']['file1']		= "mqc75_7.5.0.3_linuxx86-64.tar.gz"
   default['mqc7503']['zip']['tarfile']		= "mqc75_7.5.0.3_linuxx86-64.tar"
  
   default['mqc7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/mqc75_7.5.0.3_linuxx86-64.tar.gz"
  
when 'aix'
   
   default['mqc7503']['base']['path']		= "/usr/mqm"
   default['mqc7503']['config']['cache']	=  "/DST/mq7503_clt_base_install/unzip"

   default['mqc7503']['zip']['file1']		= "mqc75_7.5.0.3_aix.tar.Z"
   default['mqc7503']['zip']['tarfile']		= "mqc75_7.5.0.3_aix.tar"
  
   default['mqc7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/mqc75_7.5.0.3_aix.tar.Z"
  
  
when 'windows'

   default['mqc7503']['base']['path']		= "C:/mqm"

   default['mqc7503']['install']['path']	= 'C:/mqm/source/WebSphere MQ 7.5.0.3'
   default['mqc7503']['config']['cache']	= "C:/DST/mq7503_clt_base_install/unzip"
  

   default['mqc7503']['zip']['file1']		= "mqc75_7.5.0.3_win.zip"
   default['mqc7503']['exec']['file']		= "C:/DST/mq7503_clt_base_install/unzip/Windows/MSI/IBM WebSphere MQ.msi"
   default['mqc7503']['resp']['file']		= "mq7503_silent_install.resp"
   default['mqc7503']['resp']['erb']		= "mq7503_silent_install.resp.erb"
      
   default['mqc7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/mqc75_7.5.0.3_win.zip"
  
end