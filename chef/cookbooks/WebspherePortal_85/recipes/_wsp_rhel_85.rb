###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# Websphere Portal Server
#
###########################################################################################################################################
ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['wsp85']['zip']['location1']}"

REPOSITORY_LOC = node['wsp85']['config']['cache']

#############################
#
# create Cache_path for WSP
#
#############################

# Testing if the WebSphere Portal is already installed

log "-------------DST Create the directory cache path #{node['wsp85']['config']['mount']}-----------"
 
directory node['wsp85']['config']['mount'] do
 owner "root"
 group "root"
 mode "0755"
 action :create
end 

log "-------------DST Create the directory cache path #{node['wsp85']['config']['cache']}-----------"

directory node['wsp85']['config']['cache'] do
 owner "root"
 group "root"
 mode "0755"
 recursive true
 action :create
end   
  
  

#############################
#
# copy /install in cache_path
#
#############################
log "------DST Get the WebSphere Portal zip 1 file----" 

remote_file "#{node['wsp85']['config']['mount']}/#{node['wsp85']['zip']['file1']}" do
source ihs_dynamic_url_file1
action :create_if_missing
end
	

################################
#
# unzip install files
#
################################
	
log "-----------DST Unzip the WSP zip file 1--------" 

execute "Unzip IHS File 1" do
  user "root"
  cwd node['wsp85']['config']['mount']
  command "unzip -o #{node['wsp85']['zip']['file1']} -d #{node['wsp85']['config']['cache']}"
  action :run
end

######################################
#
# Create a reponse file
#
######################################
log "-------------DST Create a reponse file-----------" 
	
template "#{node['wsp85']['config']['mount']}/#{node['wsp85']['response']['file']}" do
source "#{node['wsp85']['response']['erb']}"
owner  'root'
group  'root'
mode   '0600'
action :touch
variables({
     		:repository_location => "\'#{REPOSITORY_LOC}/WP85_Server\'",
      	:installLocation     => "\'/opt/IBM/WebSphere/PortalServer\'",
     		:eclipseLocation     => "\'/opt/IBM/WebSphere/PortalServer\'",
   		:os                  => "\'linux\'",
     		:arch                => "\'x86_64\'",
     		:ws                  => "\'gtk\'",
		:config_engine       => "\'/opt/IBM/WebSphere/ConfigEngine\'",
		:was_inst_path       => "\'/opt/IBM/WebSphere/AppServer\'",
		:was_profile_path    => "\'/opt/IBM/WebSphere/AppServer/profiles\'",
		:ipnode 		     => node[:fqdn],
		:hostname		     => node[:hostname],
		:wsp_profile	     => "\'/opt/IBM/WebSphere/wp_profile\'",
     		:eclipseCache        => "\'/opt/IBM/IMShared\'"
   })
end


####################################
#
# Stop the WAS server 
#
####################################

execute "Updating was to v8.5.5.1 " do
    	   user "root"
    	   command "/opt/IBM/WebSphere/AppServer/bin/stopServer.sh server1"
    	   action :run
end


####################################
#
# install Websphere Portal silently
#
####################################
log "-----DST install WebSphere Portal silently------"

execute "Install WSP" do
 cwd node['im']['base']
 command "./imcl -acceptLicense -input #{node['wsp85']['config']['mount']}/#{node['wsp85']['response']['file']} -log #{node['wsp85']['log']['file']}"
 timeout 86400
 action :run
end

#######################################
#
# Delete unzip file
#
########################################

log "-------------DST remove cache directory-----------"

directory node['wsp85']['config']['mount'] do
  owner "root"
  group "root"
  recursive true
  action :delete
end   