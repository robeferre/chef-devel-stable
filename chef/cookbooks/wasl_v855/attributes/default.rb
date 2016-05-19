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

# URL's
default['wasl']['file']['zip']['url']           = "/install/WebSphere/WASND/wasl/WAS_Liberty_Core_V8.5.5_1_OF_3.zip"
default['wasl']['file']['zip']['checksum']			= 'be12d226708d5e8845170c9e7905dd767e6edea0be2634958a8724f0420bfc86'

# FILE NAMES
default['wasl']['file']['zip']['file_name']   	= "WAS_Liberty_Core_V8.5.5_1_OF_3.zip"

case node['platform_family']
when 'rhel'
	# PATH's
	default['im']['installation']['path']				  = "/opt/IBM/InstallationManager/eclipse/tools/"
	default['im']['cache']['path']                = "/DST/wasl855/"
	default['wasl']['config']['cache']['path'] 		= Chef::Config[:file_cache_path] + "/wasl"
when 'aix'
  # PATH's
	default['im']['installation']['path'] 				= "/opt/IBM/InstallationManager/eclipse/tools/"
	default['im']['cache']['path']                = "/DST/wasl855/"
	default['wasl']['config']['cache']['path'] 		= Chef::Config[:file_cache_path] + "/wasl"
when 'windows'
	# PATH's
	default['im']['installation']['path']			    = 'C:/Program Files/IBM/Installation Manager/eclipse/tools/'
	default['im']['cache']['path']                = "C:/DST/wasl855/"
	default['wasl']['config']['cache']['path']  	= 'C:/Program Files (x86)/IBM/wasl'
end