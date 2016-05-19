#########################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

# default URL's
default['was80']['zip1_file']['url'] = "/install/CHEF_FILES/WAS80ND/WAS/CZM9KML.zip"

default['was80']['zip2_file']['url']          = "/install/CHEF_FILES/WAS80ND/WAS/CZM9LML.zip"

default['was80']['zip3_file']['url']	           	 = "/install/CHEF_FILES/WAS80ND/WAS/CZM9MML.zip"

default['was80']['zip4_file']['url']	           	 = "/install/CHEF_FILES/WAS80ND/WAS/CZVG4ML.zip"

# default FILE_NAMES											  
default['was80']['zip1_file']['file_name']	      = "CZM9KML.zip"
default['was80']['zip2_file']['file_name']	      = "CZM9LML.zip"
default['was80']['zip3_file']['file_name']       = "CZM9MML.zip"
default['was80']['zip4_file']['file_name']       = "CZVG4ML.zip"

# default PROFILE
default['was80']['profile_name']            		   = "AppSrv01"
# default PATH
default['was80']['cache']['path'] 	   	   			   = Chef::Config[:file_cache_path] + "/was80"


case node['platform_family']
when 'windows'

default['im']['installation']['path']			       = 'C:/Program Files/IBM/Installation Manager/eclipse/tools'
	default['im']['cache']['path']                   = 'C:/DST/was_v80'
	default['was80']['installation']['path']   		   = 'C:/Program Files (x86)/IBM/WebSphere/AppServer/bin/'
	default['was80']['template']['path']       	     = 'C:/Program Files (x86)/IBM/WebSphere/AppServer/profileTemplates/default'
	# PROFILE
	default['was80']['profile']['path']  	   		     = '"C:/Program Files (x86)/IBM/WebSphere/AppServer/profiles"'
	
when 'rhel'
  
	# PATH's
	default['im']['installation']['path'] 			     = "/opt/IBM/InstallationManager/eclipse/tools"
	default['im']['cache']['path']                   = "/DST/was_v80"
	default['was80']['installation']['path']  		   = "/opt/IBM/WebSphere/AppServer/bin"
	default['was80']['template']['path'] 	  		     = "/opt/IBM/WebSphere/AppServer/profileTemplates/default" 
	# PROFILE
	default['was80']['profile']['path']  	   		     = "/opt/IBM/WebSphere/AppServer/profiles"
	
when 'aix'

	
end