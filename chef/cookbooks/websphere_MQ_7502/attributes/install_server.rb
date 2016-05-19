# Config directory
default['mq7502']['config']['mount']		=  Chef::Config[:file_cache_path] + "/mq7502_base_install"


case node['platform_family']

when 'rhel'
 
   default['mq7502']['base']['path']		= "/opt/mqm"
   default['mq7502']['config']['cache']		= "/DST/mq7502_base_install/unzip"

   default['mq7502']['zip']['file1']		= "WS_MQ_LINUX_ON_X86_64_7.5.0.2_IMG.tar.gz"
   default['mq7502']['zip']['tarfile']		= "WS_MQ_LINUX_ON_X86_64_7.5.0.2_IMG.tar"
  
   default['mq7502']['zip']['location']		= "/install/CHEF_FILES/Websphere_MQ/V75/WS_MQ_LINUX_ON_X86_64_7.5.0.2_IMG.tar.gz"
  
when 'aix'
   
   default['mq7502']['base']['path']		= "/usr/mqm"
   default['mq7502']['config']['cache']		= "/DST/mq7502_base_install/unzip"

   default['mq7502']['zip']['file1']		= "WS_MQ_FOR_AIX_V7.5.0.2.tar.z"
   default['mq7502']['zip']['tarfile']		= "WS_MQ_FOR_AIX_V7.5.0.2.tar"
  
   default['mq7502']['zip']['location']		= "/install/CHEF_FILES/Websphere_MQ/V75/WS_MQ_FOR_AIX_V7.5.0.2.tar.z"
  
  
when 'windows'

   default['mq7502']['base']['path']		= "C:/mqm"

   default['mq7502']['config']['cache']		=  "C:/DST/mq7502_base_install/unzip"
   default['mq7502']['resptemp']['file']	= "Response.ini.erb"
   default['mq7502']['resp']['file']		= "Response.ini"
   default['mq7502']['zip']['file1']		= "WS_MQ_FOR_WINDOWS_V7.5.0.2.zip"
   
   default['mq7502']['zip']['location']		= "/install/CHEF_FILES/Websphere_MQ/V75/WS_MQ_FOR_WINDOWS_V7.5.0.2.zip"
   
end