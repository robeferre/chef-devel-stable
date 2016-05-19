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
default['was8551']['zip1_file']['url'] 	           = "/install/WebSphere/WASND/FP8551/WAS/8.5.5-WS-WAS-FP0000001-part1.zip"
default['was8551']['zip1_file']['checksum']        = '507777d75ec7140143da262c8f1df64d127274302c196fff42d8fab9ed0f00e8'
default['was8551']['zip2_file']['url']	           = "/install/WebSphere/WASND/FP8551/WAS/8.5.5-WS-WAS-FP0000001-part2.zip"
default['was8551']['zip2_file']['checksum']		     = '4ce6f4be42dddd0a9fee36d1c242518476890b2c33eb659ebaa8d862083f2635'

# default FILE_NAMES											  
default['was8551']['zip1_file']['file_name']	     = "8.5.5-WS-WAS-FP0000001-part1.zip"
default['was8551']['zip2_file']['file_name']	     = "8.5.5-WS-WAS-FP0000001-part2.zip"

# default PATH
default['was8551']['cache']['path'] 	   	   			 = Chef::Config[:file_cache_path] + "/was_update_855"
default['was8551']['log']['path']	      	   	     = Chef::Config[:file_cache_path] + "/was_update_855/wassetup.log"

case node['platform_family']
when 'windows'

	# PATH's
	default['im']['installation']['path']			     = 'C:/Program Files/IBM/Installation Manager/eclipse/tools'
	default['was']['installation']['path']         = 'C:/Program Files (x86)/IBM/WebSphere/AppServer/bin/'
	default['was8551']['im']['cache']['path']      = "/DST/was8551/"

when 'rhel'

	# PATH's
	default['im']['installation']['path'] 			   = "/opt/IBM/InstallationManager/eclipse/tools"
  default['was8551']['im']['cache']['path']      = "/DST/was8551/"
  
when 'aix'

	# PATH's
	default['im']['installation']['path'] 			   = "/opt/IBM/InstallationManager/eclipse/tools"
	default['was8551']['im']['cache']['path']      = "/DST/was8551/"

end