# Config directory
default['mq7104']['config']['mount']	=  Chef::Config[:file_cache_path] + "/mq7104_base_install"


case node['platform_family']

when 'rhel'
 
   default['mq7104']['base']['path']	= "/opt/mqm"
   default['mq7104']['config']['cache']	=  "/DST/mq7104_base_install/unzip"

   default['mq7104']['zip']['file1']	= "7.1.0-WS-MQ-LinuxX64-FP0004.tar.gz"
   default['mq7104']['zip']['tarfile']	= "7.1.0-WS-MQ-LinuxX64-FP0004.tar"
  
   default['mq7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/7.1.0-WS-MQ-LinuxX64-FP0004.tar.gz"
  
when 'aix'
   
   default['mq7104']['base']['path']	= "/usr/mqm"
   default['mq7104']['config']['cache']	=  "/DST/mq7104_base_install/unzip"

   default['mq7104']['zip']['file1']	= "7.1.0-WS-MQ-AixPPC64-FP0004.tar.Z"
   default['mq7104']['zip']['tarfile']	= "7.1.0-WS-MQ-AixPPC64-FP0004.tar"
  
   default['mq7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/7.1.0-WS-MQ-AixPPC64-FP0004.tar.Z"
  
  
when 'windows'

   default['mq7104']['base']['path']	= "C:/mqm"

   default['mq7104']['install']['path'] = 'C:/mqm/source/WebSphere MQ 7.1.0.4'
   default['mq7104']['config']['cache']	=  "C:/DST/mq7104_base_install/unzip"
  

   default['mq7104']['zip']['file1']	= "7.1.0-WS-MQ-Windows-FP0004.zip"
   default['mq7104']['exec']['file']	= "WS-MQ-7.1.0-FP0004.exe"
   default['mq7104']['resp']['file']	= "mq7104_silent_install.resp"
   default['mq7104']['resp']['erb']	= "mq7104_silent_install.resp.erb"
      
   default['mq7104']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/FixPack/7.1.0-WS-MQ-Windows-FP0004.zip"
  
end