##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
##########################################################################################################

# default URL's
default['was85']['zip1_file']['url'] 	             = "/install/WebSphere/WASND/85/WASND85zip/WAS_ND_V8.5_1_OF_3.zip"
default['was85']['zip1_file']['checksum']          = '507777d75ec7140143da262c8f1df64d127274302c196fff42d8fab9ed0f00e8'
default['was85']['zip2_file']['url']	             = "/install/WebSphere/WASND/85/WASND85zip/WAS_ND_V8.5_2_OF_3.zip"
default['was85']['zip2_file']['checksum']		       = '4ce6f4be42dddd0a9fee36d1c242518476890b2c33eb659ebaa8d862083f2635'
default['was85']['zip3_file']['url']	           	 = "/install/WebSphere/WASND/85/WASND85zip/WAS_ND_V8.5_3_OF_3.zip"
default['was85']['zip3_file']['checksum']		       = '22de0d24e2395f8d7ddab9b1efe9b4fdcd11397ab6bd8acd172711976e6c4686'
# default FILE_NAMES											  
default['was85']['zip1_file']['file_name']	       = "WAS_ND_V8.5_1_OF_3.zip"
default['was85']['zip2_file']['file_name']	       = "WAS_ND_V8.5_2_OF_3.zip"
default['was85']['zip3_file']['file_name']	       = "WAS_ND_V8.5_3_OF_3.zip"
# default PROFILE
default['was85']['profile_name']            		   = "AppSrv01"
# default PATH
default['was85']['cache']['path'] 	   	   			   = Chef::Config[:file_cache_path] + "/was85"


case node['platform_family']
when 'windows'
  
	# PATH's
	default['im']['installation']['path']			       = 'C:/Program Files/IBM/Installation Manager/eclipse/tools'
	default['im']['cache']['path']                   = 'C:/DST/was_v85'
	default['was85']['installation']['path']   		   = 'C:/Program Files (x86)/IBM/WebSphere/AppServer/bin/'
	default['was85']['template']['path']       	     = 'C:/Program Files (x86)/IBM/WebSphere/AppServer/profileTemplates/default'
	# PROFILE
	default['was85']['profile']['path']  	   		     = '"C:/Program Files (x86)/IBM/WebSphere/AppServer/profiles"'
	
when 'rhel'
  
	# PATH's
	default['im']['installation']['path'] 			     = "/opt/IBM/InstallationManager/eclipse/tools"
	default['im']['cache']['path']                   = "/DST/was_v85"
	default['was85']['installation']['path']  		   = "/opt/IBM/WebSphere/AppServer/bin"
	default['was85']['template']['path'] 	  		     = "/opt/IBM/WebSphere/AppServer/profileTemplates/default" 
	# PROFILE
	default['was85']['profile']['path']  	   		     = "/opt/IBM/WebSphere/AppServer/profiles"
	
when 'aix'

	# PATH's
	default['im']['installation']['path'] 			     = "/opt/IBM/InstallationManager/eclipse/tools"
	default['im']['cache']['path']                   = "/DST/was_v85"
	default['was85']['installation']['path']   		   = "/usr/IBM/WebSphere/AppServer/bin"
	default['was85']['template']['path'] 			       = "/usr/IBM/WebSphere/AppServer/profileTemplates/default" 
	# PROFILE
	default['was85']['profile']['path']  	   		     = "/usr/IBM/WebSphere/AppServer/profiles"

end