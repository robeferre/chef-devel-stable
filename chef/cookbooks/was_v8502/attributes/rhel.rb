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

default['was8502']['package1_url']		= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WAS-FP0000002-part1.zip"
default['was8502']['package2_url']		= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WAS-FP0000002-part2.zip"
default['was8502']['supplement1_url']	= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WASSupplements-FP0000002-part1.zip"
default['was8502']['supplement2_url']	= "/install/CHEF_FILES/WAS8502ND/8.5.0-WS-WASSupplements-FP0000002-part2.zip"
default['was8502']['package_file1']		= "8.5.0-WS-WAS-FP0000002-part1.zip"
default['was8502']['package_file2']		= "8.5.0-WS-WAS-FP0000002-part2.zip"		  
default['was8502']['supplement_file1']	= "8.5.0-WS-WASSupplements-FP0000002-part1.zip"
default['was8502']['supplement_file2']	= "8.5.0-WS-WASSupplements-FP0000002-part2.zip"
default['was8502']['im_tools_path']		= "/opt/IBM/InstallationManager/eclipse/tools"
default['was8502']['im_cache_path']		= "/DST/was_v8502"
default['was8502']['cache_path']		= Chef::Config[:file_cache_path] + "/was_v8502_Update"