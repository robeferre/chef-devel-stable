#
# WINDOWS
#
# Basic
case node['platform_family']
when 'windows'
  default['config']['mount']['path']  = 'C:/Program Files (x86)/IBM' 
  default['config']['cache']['path']  = Chef::Config[:file_cache_path] + "/im" 
  default['im']['install']['path']     = 'C:/Program Files/IBM/Installation Manager/eclipse/tools/'

# Sources
  default['im']['zip']['file_name']   = 'agent.installer.win32.win32.x86_64_1.7.0.20130828_2012.zip' 
  default['im']['zip']['checksum']    = '012aca6cef50ed784f239d1ed5f6923b741d8530b70d14e9abcb3c7299a826cc'
  default['im']['zip']['url']     = "/install/CHEF_FILES/IM/agent.installer.win32.win32.x86_64_1.7.0.20130828_2012.zip"
end

