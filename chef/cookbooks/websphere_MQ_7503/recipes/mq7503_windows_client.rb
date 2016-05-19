###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mqc7503']['zip']['location']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

log "---DST - Create the directory #{node['mqc7503']['config']['mount']}----" 
 
directory node['mqc7503']['config']['mount'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  
log "----DST - Create the directory #{node['mqc7503']['config']['cache']}----" 

directory node['mqc7503']['config']['cache'] do
 rights :full_control,'Administrator'
 recursive true
 action :create
end   
  

##################################
#
# copy /install in cache_path
#
##################################
log "-----DST - Get the Websphere MQ client V7503 zip 1 file----"

remote_file "#{node['mqc7503']['config']['mount']}/#{node['mqc7503']['zip']['file1']}" do
source ihs_dynamic_url_file
action :create_if_missing
end
	
################################
#
# unzip install files
#
################################
	
log "---- DST - Unzip the Websphere MQ client zip file 1----" 

windows_zipfile "#{node['mqc7503']['config']['cache']}" do
  source "#{node['mqc7503']['config']['mount']}/#{node['mqc7503']['zip']['file1']}"
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

windows_package 'mq_7503 client install' do
  source node['mqc7503']['exec']['file']
  options '/l*v c:\\install.log /qn ADDLOCAL="Client,JavaMsg,Toolkit" PGMFOLDER="c:\mqm" AGREETOLICENSE="yes" REMOVEFEATURES="yes" LAUNCHWIZ="0"'
  installer_type :custom
  action :install
end
	
#######################################
#
# Delete unzip file
#
########################################
log "remove cache directory" do
 level :info
end

directory node['mqc7503']['config']['mount'] do
  recursive true
  action :delete
end   
