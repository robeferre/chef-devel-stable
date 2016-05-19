##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Daniel Abraao Silva Costa
# Contact: dasc@br.ibm.com
#
##########################################################################################################

default['was8552']['package1_url']		= "/install/CHEF_FILES/WAS8552ND/8.5.5-WS-WAS-FP0000002-part1.zip"
default['was8552']['package2_url']		= "/install/CHEF_FILES/WAS8552ND/8.5.5-WS-WAS-FP0000002-part2.zip"
default['was8552']['package_file1']		= "8.5.5-WS-WAS-FP0000002-part1.zip"
default['was8552']['package_file2']		= "8.5.5-WS-WAS-FP0000002-part2.zip"		  
default['was8552']['im_tools_path']		= "/opt/IBM/InstallationManager/eclipse/tools"
default['was8552']['im_cache_path']		= "/DST/was_v8552"
default['was8552']['cache_path']		= Chef::Config[:file_cache_path] + "/was_v8552_Update"