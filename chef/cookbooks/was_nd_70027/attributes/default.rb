##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################



default['profile_name']            		       = "AppSrv01"
default['cache']['path']                     = Chef::Config[:file_cache_path] + "/was70"

case node['platform_family']
when 'windows'
  default['was70cache']['path']           =  'C:/tmp/chef-solo/was70'
	default['installer']['url']              = "/install/CHEF_FILES/WAS70ND/nd_x86-WIN64/C1G0TML.zip"
	default['update_installer']['url']       = "/install/CHEF_FILES/WAS70ND/nd_x86-WIN64/C1G0UML.zip"
	default['fixpack27']['url']              = "/install/CHEF_FILES/WAS70ND/nd_x86-WIN64/7.0.0-WS-WAS-WinX64-FP0000027.pak"
	default['fixpack27']['file_name']        = "7.0.0-WS-WAS-WinX64-FP0000027.pak"
	default['installer']['file_name']        = "C1G0TML.zip"
  default['update_installer']['file_name'] = "C1G0UML.zip"
  default['installation']['path']   	     = 'C:/Program Files/IBM/WebSphere/AppServer/bin/'
	default['template']['path']       	     = 'C:/Program Files/IBM/WebSphere/AppServer/profileTemplates/default'
  default['profile']['path']  	   		     = '"C:/Program Files/IBM/WebSphere/AppServer/profiles"'
when 'rhel'
  default['cache']['path']                  = Chef::Config[:file_cache_path] + "/was70"
  default['installer']['file_name']         = "was_install.tar"
  default['update_installer']['file_name']  = "updateInstaller.tar"
  default['fixpack27']['file_name']         = "7.0.0-WS-WAS-LinuxX64-FP0000027.pak"
	default['installer']['url'] 	            = "/install/CHEF_FILES/WAS70ND/nd_x86-64/was_install.tar"
	default['update_installer']['url']	      = "/install/CHEF_FILES/WAS70ND/nd_x86-64/UpdateInstaller.tar"
	default['fixpack27']['url']	              = "/install/CHEF_FILES/WAS70ND/FixPack/7.0.0-WS-WAS-LinuxX64-FP0000027.pak"
  default['installation']['path']  		      = "/opt/IBM/WebSphere/AppServer/bin"
	default['template']['path'] 	  		      = "/opt/IBM/WebSphere/AppServer/profileTemplates/default"
	default['profile']['path']  	   		      = "/opt/IBM/WebSphere/AppServer/profiles"
end