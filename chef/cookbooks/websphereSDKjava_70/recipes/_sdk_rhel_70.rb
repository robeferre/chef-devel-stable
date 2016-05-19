###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM websphere SDK java 7.0
#
#################################################################

ihs_dynamic_url_file1 = "http://#{$BEST_SERVER}#{node['sdk70']['zip']['location']}"

REPOSITORY_LOC   = node['sdk70']['config']['cache']

#############################
#
# create Cache_path for sdk 7
#
#############################

log "-------------DST Create the directory cache path #{node['sdk70']['config']['mount']}-----------"
 
directory node['sdk70']['config']['mount'] do
 owner "root"
 group "root"
 mode "0755"
 action :create
end 

log "-------------DST Create the directory cache path #{node['sdk70']['config']['cache']}-----------"

directory node['sdk70']['config']['cache'] do
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
log "-------------DST Get the SDK Java zip file-----------" 

remote_file "#{node['sdk70']['config']['mount']}/#{node['sdk70']['zip']['file1']}" do
source ihs_dynamic_url_file1
action :create_if_missing
end
	
################################
#
# unzip install files
#
################################
	
log "-------------DST Unzip the SDK JAVA zip file -----------" 

execute "Unzip sdk Java File " do
  user "root"
  cwd node['sdk70']['config']['mount']
  command "unzip -o #{node['sdk70']['zip']['file1']} -d #{node['sdk70']['config']['cache']}"
  action :run
end


######################################
#
# Create a reponse file
#
######################################

log "-------------DST Create a reponse file-----------" 
	
template "#{node['sdk70']['config']['mount']}/#{node['sdk70']['response']['file']}" do
source "#{node['sdk70']['response']['erb']}"
owner  'root'
group  'root'
mode   '0600'
action :touch
variables({
      :repository_location => "\'#{REPOSITORY_LOC}/IBMJAVA7\'",
      :installLocation     => "\'/opt/IBM/WebSphere/AppServer\'",
      :eclipseLocation     => "\'/opt/IBM/WebSphere/AppServer\'",
      :os                  => "\'linux\'",
      :arch                => "\'x86\'",
      :ws                  => "\'gtk\'",
      :eclipseCache        => "\'/opt/IBM/IMShared\'"
    })
end

####################################
#
# install SDK Java 7.0 silently
#
####################################
log "-------------DST install ihs silently-----------"

execute "Install IHS" do
 cwd node['im']['base']
 command "./imcl -acceptLicense -input #{node['sdk70']['config']['mount']}/#{node['sdk70']['response']['file']} -log #{node['sdk70']['log']['file']}"
 action :run
end

#######################################
#
# Delete unzip file
#
########################################

log "-------------DST remove cache directory-----------"

directory node['sdk70']['config']['mount'] do
  owner "root"
  group "root"
  recursive true
  action :delete
end   
