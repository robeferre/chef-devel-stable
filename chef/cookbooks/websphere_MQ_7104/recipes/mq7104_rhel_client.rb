###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mqc7104']['zip']['location']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

log "---DST - Create the directory #{node['mqc7104']['config']['mount']}----" 
 
directory node['mqc7104']['config']['mount'] do
 owner "root"
 group "root"
 mode "0755"
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mqc7104']['config']['cache']}----" 

directory node['mqc7104']['config']['cache'] do
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
log "-----DST - Get the Websphere MQ Client V7104 zip file----"

remote_file "#{node['mqc7104']['config']['mount']}/#{node['mqc7104']['zip']['file1']}" do
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
  cwd node['mqc7104']['config']['mount']
  command "gzip -d #{node['mqc7104']['zip']['file1']}"
  action :run
end
	
log "----DST - Unzip the Websphere MQ zip file ----"
	
execute "untar mqc file.tar " do
  user "root"
  cwd node['mqc7104']['config']['cache']
  command "tar -xvf #{node['mqc7104']['config']['mount']}/#{node['mqc7104']['zip']['tarfile']} "
  action :run
end
	


####################################
#
# install Websphere MQ Server
#
####################################

log "----DST - Accept license websphere MQ Server ----" 

execute "Accept license websphere MQ Server" do
 cwd node['mqc7104']['config']['cache']
 command "./mqlicense.sh -accept"
 action :run
end


log "----DST - install websphere MQ Server ----" 

execute "Install websphere MQ Client" do
 cwd node['mqc7104']['config']['cache']
 command "rpm -ivh MQSeries*.rpm"
 action :run
end
	
log "----DST - set it as the primary installation ----" 

execute "Set it as primary installation" do
  cwd node['mqc7104']['base']['path'] + "/bin/"
  command "./setmqinst -i -p /opt/mqm"
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

directory node['mqc7104']['config']['mount'] do
  owner "root"
  recursive true
  action :delete
end   


