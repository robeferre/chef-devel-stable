#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################
#
# IBM Cognos BI V10.2.1 for Linux
#
#################################################################

cognos_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['cognos1021']['zip']['location1']}"

RESPONSE_FILE_PATH = "#{node['cognos1021']['config']['cache']}/#{node['cognos1021']['resp']['ats']}"


if (!(File.directory?(node['cognos1021']['base_install'])))

####################################
#
# create Cache_path for Cognos
#
####################################


	log "----DST Create the directory cache path #{node['cognos1021']['config']['mount']}---"
 
	directory node['cognos1021']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 


log "----DST Create the directory cache path #{node['cognos1021']['config']['cache']}---"
	directory node['cognos1021']['config']['cache'] do
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
	log "-----DST Get the Cognos BI server zip 1 file-----" 

	remote_file "#{node['cognos1021']['config']['mount']}/#{node['cognos1021']['zip']['file1']}" do
	source cognos_dynamic_url_file1
	action :create_if_missing
	end
	
	################################
	#
	# unzip install files
	#
	################################
	
	log "----DST - Unzip the cognos BI Server zip file ----"
	
	execute "extract Gzip cognos file.tar.gz " do
	  user "root"
	  cwd node['cognos1021']['config']['mount']
	  command " gzip -d #{node['cognos1021']['zip']['file1']}"
	  action :run
	end
	
	log "----DST - Unzip the cognos BI Server zip file ----"
	
	execute "untar cognos file.tar " do
	  user "root"
	  cwd node['cognos1021']['config']['cache']
	  command "tar -xvf #{node['cognos1021']['config']['mount']}/#{node['cognos1021']['zip']['tarfile1']} "
	  action :run
	end

	####################################################
	#
	# Create response file
	#
	####################################################


   log " ----DST - Create a reponse file -----"

   template "#{RESPONSE_FILE_PATH}" do
     source node['cognos1021']['resp']['erb']	
	owner 'root'
	group 'root'
	mode '0600'
     action :touch
   end


	############################################################
	#
	# installation IBM Cognos BI Server
	#
	#########################################################


 	    log " -----DST - Installation of cognos 10.2.1-----"

    execute "Install cognos 1021" do
      cwd node['cognos1021']['install']['cache']
      command "./issetupnx -s #{RESPONSE_FILE_PATH}"
      action :run
    end


 		log "-------DST remove cache directory--------"

	directory node['cognos1021']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "Cognos Business Intelligence V10.2.1 is already installed on this machine." do
  level :info
  end
end


