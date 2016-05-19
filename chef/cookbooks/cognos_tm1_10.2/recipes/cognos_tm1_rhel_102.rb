#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# IBM Cognos BI & Cognos TM1 V10.2 for Linux
#
#################################################################

cognos_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['cognos102']['zip']['location1']}"
cognos_dynamic_url_file2 = "http://#{$BEST_SERVER}#{node['cognos102']['zip']['location2']}"

RESPONSE_FILE_PATH = "#{node['cognos102']['config']['cache']}/#{node['cognos102']['resp']['ats']}"

if (!(File.directory?(node['cognos102']['base_install'])))

####################################
#
# create Cache_path for Cognos
#
####################################


	log "----DST Create the directory cache path #{node['cognos102']['config']['mount']}---"
 
	directory node['cognos102']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 


log "----DST Create the directory cache path #{node['cognos102']['config']['cache']}---"
	directory node['cognos102']['config']['cache'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	 recursive true
	end   
  
	#############################
	#
	# copy /install in cache_path
	#
	#############################
	log "-----DST Get the Cognos tm1 server zip 1 file-----" 

	remote_file "#{node['cognos102']['config']['mount']}/#{node['cognos102']['zip']['file1']}" do
	source cognos_dynamic_url_file1
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	
	log "----DST - Unzip the cognos tm1 Server zip file ----"
	
	execute "extract Gzip cognos file.tar.gz " do
	  user "root"
	  cwd node['cognos102']['config']['mount']
	  command " gzip -d #{node['cognos102']['zip']['file1']}"
	  action :run
	end
	
	log "----DST - Unzip the cognos tm1 Server zip file ----"
	
	execute "untar cognos file.tar " do
	  user "root"
	  cwd node['cognos102']['config']['cache']
	  command "tar -xvf #{node['cognos102']['config']['mount']}/#{node['cognos102']['zip']['tarfile1']} "
	  action :run
	end


	####################################################
	#
	# Create response file
	#
	####################################################


   log " ----DST - Create a reponse file -----"

   template "#{RESPONSE_FILE_PATH}" do
     source node['cognos102']['resp']['erb']	
	owner 'root'
	group 'root'
	mode '0600'
     action :touch
   end

	############################################################
	#
	# installation IBM Cognos BI Server
	#
	############################################################

 	    log " -------DST - Installation of cognos 10.2-----"

    execute "Install cognos 102" do
      cwd node['cognos102']['install']['cache']
      command "./issetupnx -s #{RESPONSE_FILE_PATH}"
      action :run
    end

 	log "-------DST remove cache directory--------"

	directory node['cognos102']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   


else
  log "Cognos TM1 V10.2 is already installed on this machine." do
  level :info
  end
end


