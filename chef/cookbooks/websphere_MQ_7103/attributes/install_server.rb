# Config directory
default['mq7103']['config']['mount']	=  Chef::Config[:file_cache_path] + "/mq7103_base_install"


case node['platform_family']

when 'rhel'
 
   default['mq7103']['base']['path']	= "/opt/mqm"
   default['mq7103']['config']['cache']	=  "/DST/mq7103_base_install/unzip"

   default['mq7103']['zip']['file1']	= "WS_MQ_V7.1.0.3_LNX_X86_64_ML.tar.gz"
   default['mq7103']['zip']['tarfile']	= "WS_MQ_V7.1.0.3_LNX_X86_64_ML.tar"
  
   default['mq7103']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/WS_MQ_V7.1.0.3_LNX_X86_64_ML.tar.gz"
  
when 'aix'
   
   default['mq7103']['base']['path']	= "/usr/mqm"
   default['mq7103']['config']['cache']	=  "/DST/mq7103_base_install/unzip"

   default['mq7103']['zip']['file1']	= "WEBSPHERE_MQ_V7.1.0.3_FOR_AIX_ML.tar.z"
   default['mq7103']['zip']['tarfile']	= "WEBSPHERE_MQ_V7.1.0.3_FOR_AIX_ML.tar"
  
   default['mq7103']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/WEBSPHERE_MQ_V7.1.0.3_FOR_AIX_ML.tar.z"
  
  
when 'windows'

   default['mq7103']['base']['path']	= "C:/mqm"

   default['mq7103']['config']['cache']	=  "C:/DST/mq7103_base_install/unzip"
  

   default['mq7103']['zip']['file1']	= "WS_MQ_V7.1.0.3_DOC_FOR_WINS_EIMAGE.zip"
   
   default['mq7103']['zip']['location']	= "/install/CHEF_FILES/Websphere_MQ/V71/WS_MQ_V7.1.0.3_DOC_FOR_WINS_EIMAGE.zip"
  
end