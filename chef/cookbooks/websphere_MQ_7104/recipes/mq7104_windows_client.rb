###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
#RESPONSE_FILE_PATH = "#{node['mqc7104']['config']['cache']}/#{node['mqc7104']['resp']['file']}"
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mqc7104']['zip']['location']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

log "---DST - Create the directory #{node['mqc7104']['config']['mount']}----" 
 
directory node['mqc7104']['config']['mount'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mqc7104']['config']['cache']}----" 

directory node['mqc7104']['config']['cache'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  

##################################
#
# copy /install in cache_path
#
##################################
log "-----DST - Get the Websphere MQ client V7104 zip 1 file----"

remote_file "#{node['mqc7104']['config']['mount']}/#{node['mqc7104']['zip']['file1']}" do
source ihs_dynamic_url_file
action :create_if_missing
end
	
################################
#
# unzip install files
#
################################
	
log "---- DST - Unzip the Websphere MQ client zip file 1----" 

windows_zipfile "#{node['mcq7104']['config']['cache']}" do
  source "#{node['mqc7104']['config']['mount']}/#{node['mqc7104']['zip']['file1']}"
  action :unzip
  overwrite true
end


def package(*args, &blk)
   windows_package(*args, &blk)
end

		
####################################
#
# install Websphere MQ Server
#
####################################

log "----DST - install websphere MQ Server ----" 

windows_package 'mq_7104 client install' do
  source node['mqc7104']['exec']['file']
  options '/l*v c:\\install.log /qn ADDLOCAL="Client,JavaMsg,Toolkit" PGMFOLDER="c:\mqm" AGREETOLICENSE="yes" REMOVEFEATURES="yes" LAUNCHWIZ="0"'
  installer_type :custom
  action :install
end

#log "--- DST - Start MQ service ---------"
#execute"start MQ service" do
#cwd node['mqc7104']['config']['cache']
#command "net start MQ_Installation1"
#action :run
#end
	
#######################################
#
# Delete unzip file
#
########################################
log "remove cache directory" do
 level :info
end

directory node['mqc7104']['config']['mount'] do
  recursive true
  action :delete
end   
