###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################
#
# IHS Server (HTTP SERVER)
#
##########################################################

ihs_start = node['ihs70027']['base']['path'] + "/bin"

	#######################################
	#
	# Start IHS 
	#
	#######################################

	log " Start IHS " do 
	  level :info
	end

	execute "Start IHS Server" do
	  cwd ihs_start
	  command "apache.exe -k start"
	  action :run
	end

