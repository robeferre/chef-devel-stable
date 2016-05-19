# Config directory
default['mq7503']['config']['mount']	=  Chef::Config[:file_cache_path] + "/mq7503_base_install"


case node['platform_family']

when 'rhel'
 
   default['mq7503']['base']['path']	= "/opt/mqm"
   default['mq7503']['config']['cache']	=  "/DST/mq7503_base_install/unzip"

   default['mq7503']['zip']['file1']	= "7.5.0-WS-MQ-LinuxX64-FP0003.tar.gz"
   default['mq7503']['zip']['tarfile']	= "7.5.0-WS-MQ-LinuxX64-FP0003.tar"
  
   default['mq7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/7.5.0-WS-MQ-LinuxX64-FP0003.tar.gz"
  
when 'aix'
   
   default['mq7503']['base']['path']	= "/usr/mqm"
   default['mq7503']['config']['cache']	=  "/DST/mq7503_base_install/unzip"

   default['mq7503']['zip']['file1']	= "7.5.0-WS-MQ-AixPPC64-FP0003.tar.Z"
   default['mq7503']['zip']['tarfile']	= "7.5.0-WS-MQ-AixPPC64-FP0003.tar"
  
   default['mq7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/7.5.0-WS-MQ-AixPPC64-FP0003.tar.Z"
  
  
when 'windows'

   default['mq7503']['base']['path']	= "C:/mqm"
   default['mq7503']['install']['path'] = 'C:/mqm/source/WebSphere MQ 7.5.0.3'

   default['mq7503']['config']['cache']	=  "C:/DST/mq7503_base_install/unzip"
  

   default['mq7503']['zip']['file1']	= "7.5.0-WS-MQ-Windows-FP0003.zip"
   default['mq7503']['exec']['file']	= "WS-MQ-7.5.0-FP0003.exe"
   default['mq7503']['resp']['file']	= "mq7503_silent_install.resp"
   default['mq7503']['resp']['erb']	= "mq7503_silent_install.resp.erb"
  
   default['mq7503']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V75/FixPack/7.5.0-WS-MQ-Windows-FP0003.zip"
  
end