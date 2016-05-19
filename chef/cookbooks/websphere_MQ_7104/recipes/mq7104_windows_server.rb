###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
RESPONSE_FILE_PATH = "#{node['mq7104']['config']['cache']}/#{node['mq7104']['resp']['file']}"
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mq7104']['zip']['location']}"

#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

log "---DST - Create the directory #{node['mq7104']['config']['mount']}----" 
 
directory node['mq7104']['config']['mount'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mq7104']['config']['cache']}----" 

directory node['mq7104']['config']['cache'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  

##################################
#
# copy /install in cache_path
#
##################################
log "-----DST - Get the Websphere MQ V7104 zip 1 file----"

remote_file "#{node['mq7104']['config']['mount']}/#{node['mq7104']['zip']['file1']}" do
source ihs_dynamic_url_file
action :create_if_missing
end
	
################################
#
# unzip install files
#
################################
	
log "---- DST - Unzip the Websphere MQ zip file 1----" 

windows_zipfile "#{node['mq7104']['config']['cache']}" do
  source "#{node['mq7104']['config']['mount']}/#{node['mq7104']['zip']['file1']}"
  action :unzip
  overwrite true
end


def package(*args, &blk)
   windows_package(*args, &blk)
end

##################################
#
# Create response file
#
##################################

log " ----DST - Create a reponse file -----"

template "#{RESPONSE_FILE_PATH}" do
  source node['mq7104']['resp']['erb']	
  action :touch
end				

			
####################################
#
# install Websphere MQ Server
#
####################################
log "----DST - install websphere MQ Server ----" 

execute "installation of mq 7104" do
cwd node['mq7104']['config']['cache']
command "WS-MQ-7.1.0-FP0004.exe -f #{RESPONSE_FILE_PATH}"
action :run
end

log "--- DST - Start MQ service ---------"
execute"start MQ service" do
cwd node['mq7104']['config']['cache']
command "net start MQ_Installation1"
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

directory node['mq7104']['config']['mount'] do
  recursive true
  action :delete
end   
