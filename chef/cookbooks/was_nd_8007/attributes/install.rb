# Config directory
default['was8007']['config']['mount']	=  Chef::Config[:file_cache_path] + "/was_nd_8007_base_install"


case node['platform_family']

when 'rhel'

   # Installation Manager
   default['im']['base']['path']		= '/opt/IBM/InstallationManager/eclipse/tools'

   default['was8007']['config']['cache']	= "/DST/was_nd_8007_base_install/unzip"
   default['was8007']['zip']['file1']		= "8.0.0-WS-WAS-FP0000007-part1.zip"
   default['was8007']['zip']['file2']		= "8.0.0-WS-WAS-FP0000007-part2.zip"
   default['was8007']['zip']['location1']	= '/install/CHEF_FILES/WAS80ND/FixPack/8.0.0-WS-WAS-FP0000007-part1.zip '
   default['was8007']['zip']['location2']	= '/install/CHEF_FILES/WAS80ND/FixPack/8.0.0-WS-WAS-FP0000007-part2.zip '

   default['was8007']['response']['erb']	= "was_nd_8007_resp.xml.erb"
   default['was8007']['response']['file']	= "was_nd_8007_resp.xml"
 
when 'aix'
   

when 'windows'

  # Installation Manager
   default['im']['base']['path']		= 'C:/Program Files/IBM/Installation Manager/eclipse/tools'

   default['was8007']['base']['path']		= "C:/bpm"
   
   default['was8007']['config']['cache']	= "C:/DST/was_nd_8007_base_install/unzip"
   default['was8007']['zip']['file1']		= "8.0.0-WS-WAS-FP0000007-part1.zip"
   default['was8007']['zip']['file2']		= "8.0.0-WS-WAS-FP0000007-part2.zip"
   default['was8007']['zip']['location1']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/WAS80ND/FixPack/8.0.0-WS-WAS-FP0000007-part1.zip '
   default['was8007']['zip']['location2']	= 'http://dst.lexington.ibm.com/install/CHEF_FILES/WAS80ND/FixPack/8.0.0-WS-WAS-FP0000007-part2.zip '

   default['was8007']['response']['erb']	= "was_nd_8007_resp.xml.erb"
   default['was8007']['response']['file']	= "was_nd_8007_resp.xml"
end