###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mq7503']['zip']['location']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

log "---DST - Create the directory #{node['mq7503']['config']['mount']}----" 
 
directory node['mq7503']['config']['mount'] do
 owner "root"
 group "root"
 mode "0755"
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mq7503']['config']['cache']}----" 

directory node['mq7503']['config']['cache'] do
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
log "-----DST - Get the Websphere MQ V7503 zip file----"

remote_file "#{node['mq7503']['config']['mount']}/#{node['mq7503']['zip']['file1']}" do
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
  cwd node['mq7503']['config']['mount']
  command " gzip -d #{node['mq7503']['zip']['file1']}"
  action :run
end
	
log "----DST - Unzip the Websphere MQ zip file ----"
	
execute "untar mq file.tar " do
  user "root"
  cwd node['mq7503']['config']['cache']
  command "tar -xvf #{node['mq7503']['config']['mount']}/#{node['mq7503']['zip']['tarfile']} "
  action :run
end
	


####################################
#
# install Websphere MQ Server
#
####################################
log "----DST - install websphere MQ Server ----" 

execute "Install websphere MQ Server" do
 cwd node['mq7503']['config']['cache']
 command "rpm -ivh MQSeries*.rpm"
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

directory node['mq7503']['config']['mount'] do
  owner "root"
  recursive true
  action :delete
end   


