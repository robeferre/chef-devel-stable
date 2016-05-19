###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################
#
# IHS Server (HTTP SERVER)
#
##########################################################


	#######################################
	#
	# Start IHS 
	#
	#######################################

	log " Start IHS " do 
	  level :info
	end

	execute "Start IHS Server" do
	  user "root"
	  cwd node['ihs70027']['base']['path']
	  command "#{node['ihs70027']['base']['path']}/bin/apachectl start"
	  action :run
	end

	###########################################################
	#
	# Add Http start in rc.local
	#
	###########################################################

	log "----DST Add http start in rc.local -----" do 
	  level :info
	end
	
	if (!(File.readlines("/etc/rc.local").grep(/apachectl start/).any?))
		execute "Add http start in rc.local" do
		  user "root"
		  cwd node['ihs70027']['base']['path']
		  command "echo /opt/IBM/HTTPServer/bin/apachectl start >> /etc/rc.local"
		  action :run
		end
	end