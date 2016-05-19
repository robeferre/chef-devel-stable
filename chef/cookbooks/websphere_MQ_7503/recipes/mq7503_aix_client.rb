###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mqc7503']['zip']['location']}"

log "---DST - Create the directory #{node['mqc7503']['config']['mount']}----" 
 
directory node['mqc7503']['config']['mount'] do
 owner "root"
 group "root"
 mode "0755"
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mqc7503']['config']['cache']}----" 

directory node['mqc7503']['config']['cache'] do
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

remote_file "#{node['mqc7503']['config']['mount']}/#{node['mqc7503']['zip']['file1']}" do
 source ihs_dynamic_url_file
 action :create_if_missing
end
	
	
################################
#
# unzip install files
#
################################

log "----DST - Unzip the Websphere MQ zip file ----"
	
execute "extract Gzip mqfile.tar.z " do
  user "root"
  cwd node['mqc7503']['config']['mount']
  command "gzip -d #{node['mqc7503']['zip']['file1']}"
  action :run
end
	
log "----DST - Unzip the Websphere MQ zip file ----"

execute "untar mq file.tar " do
  user "root"
  cwd node['mqc7503']['config']['cache']
  command "tar -xvf #{node['mqc7503']['config']['mount']}/#{node['mqc7503']['zip']['tarfile']} "
  action :run
end
	
####################################
#
# install Websphere MQ Server
#
####################################
log "----DST - install websphere MQ Server ----" 

execute "Install websphere MQ Server" do
 cwd node['mqc7503']['config']['cache']
 command "installp -acgXYd. all"
 action :run
end

log "----DST - set it as the primary installation ----" 

execute "Set it as primary installation" do
 cwd node['mqc7503']['base']['path'] + "/bin/"
 command "setmqinst -i -p /usr/mqm"
 action :run
end

#######################################
#
# Delete unzip file
#
########################################
log "---DST - remove cache directory----" 

directory node['mqc7503']['config']['mount'] do
  owner "root"
  recursive true
  action :delete
end   
