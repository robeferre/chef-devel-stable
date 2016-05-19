###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Author:  Sandrine flageul
# Contact: flageuls@fr.ibm.com
#
# Websphere MQ Series Server
#
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mq7502']['zip']['location']}"

#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

if (!(File.directory?(node['mq7502']['base']['path'])))

	log "---DST - Create the directory #{node['mq7502']['config']['mount']}----" 
 
	directory node['mq7502']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 recursive true
	 action :create
	end   
  
	log "----DST - Create the directory #{node['mq7502']['config']['cache']}----" 

	directory node['mq7502']['config']['cache'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 recursive true
	 action :create
	end   
  

	##################################
	#
	# copy /install in cache_path
	#
	##################################
	log "-----DST - Get the Websphere MQ V7502 zip 1 file----"

	remote_file "#{node['mq7502']['config']['mount']}/#{node['mq7502']['zip']['file1']}" do
	    source ihs_dynamic_url_file
	    action :create_if_missing
	end
	
	
	################################
	#
	# unzip install files
	#
	################################
	
	log "----DST - Unzip the Websphere MQ zip file ----"
	
	execute "extract Gzip mqfile.tar.gz " do
	  user "root"
	  cwd node['mq7502']['config']['mount']
	  command " gzip -d #{node['mq7502']['zip']['file1']}"
	  action :run
	end
	
	log "----DST - Unzip the Websphere MQ zip file ----"
	
	execute "untar mq file.tar " do
	  user "root"
	  cwd node['mq7502']['config']['cache']
	  command "tar -xvf #{node['mq7502']['config']['mount']}/#{node['mq7502']['zip']['tarfile']} "
	  action :run
	end
	

	####################################
	#
	# install Websphere MQ Server
	#
	####################################

	log "----DST - Accept license websphere MQ Server ----" 

	execute "Accept license websphere MQ Server" do
	 cwd node['mq7502']['config']['cache']
	 command "./mqlicense.sh -accept"
	 action :run
	end


	log "----DST - install websphere MQ Server ----" 

	execute "Install websphere MQ Server" do
	 cwd node['mq7502']['config']['cache']
	 command "rpm -ivh MQSeries*.rpm"
	 action :run
	end

	log "----DST - set it as the primary installation ----" 

	execute "Set it as primary installation" do
	 cwd node['mq7502']['base']['path'] + "/bin/"
	 command "./setmqinst -i -p #{node['mq7502']['base']['path']}"
	 action :run
	end
	

	#######################################
	#
	# Delete unzip file
	#
	########################################
	log "remove cache directory" do
	 level :info
	end
	directory node['mq7502']['config']['mount'] do
	  owner "root"
	  recursive true
	  action :delete
	end   
else

  log "a version of IBM Websphere MQ Server already installed or a IBM Websphere MQ folder already exist!" do
  level :info
  end

end

