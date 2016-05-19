###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
###########################################################################################################################################
#
# IBM Tivoli Directory Server 6.3
#
###########################################################################################################################################
tds_dynamic_url_file = "http://#{$BEST_SERVER}#{node['tds']['zip']['location']}"

if (!(File.directory?(node['tds']['base_install'])))


#############################
#
# create Cache_path for P8 doc
#
#############################

log "-------------DST Create the directory cache path #{node['tds']['config']['mount']}-----------"
 
	directory node['tds']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 

log "---DST Create the directory cache path #{node['tds']['config']['cache']}---"

	directory node['tds']['config']['cache'] do
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
log "------DST Get the FileNet Documentation zip file----" 

	remote_file "#{node['tds']['config']['mount']}/#{node['tds']['zip']['file']}" do
	source tds_dynamic_url_file
	action :create_if_missing
	end
	

	################################
	#
	# unzip install files
	#
	################################
	

	log "-----DST Untar the TDS zip file 1-----" do
	   level :info
	end

	execute "Untar tds" do
    	user "root"
    	cwd node['tds']['config']['cache']
    	command "tar -xvf #{node['tds']['config']['mount']}/#{node['tds']['zip']['file']}"
   	   action :run
	end

	####################################
	#
	# install FileNet P8 dst silently
	#
	####################################

	execute "Install ldap cltjava63" do
	 cwd node['tds']['base']['path']
	 command "yum -y install ksh"
	 action :run
	end

	execute "Install ldap cltjava63" do
	 cwd node['tds']['base']['path']
	 command "rpm -ihv idsldap-cltjava63-6.3.0-0.x86_64.rpm"
	 action :run
	end

	execute "Install ldap cltbase63" do
	 cwd node['tds']['base']['path']
	 command "rpm -ivh idsldap-cltbase63-6.3.0-0.x86_64.rpm"
	 action :run
	end

	execute "Install ldap-clt64bit63" do
	 cwd node['tds']['base']['path']
	 command "rpm -ivh idsldap-clt64bit63-6.3.0-0.x86_64.rpm"
	 action :run
	end

	execute "Install srvbase64" do
	 cwd node['tds']['base']['path']
	 command "rpm -ivh idsldap-srvbase64bit63-6.3.0-0.x86_64.rpm"
	 action :run
	end

	execute "Install srvbase64" do
	 cwd node['tds']['base']['path']
	 command "rpm -ivh idsldap-srvproxy64bit63-6.3.0-0.x86_64.rpm"
	 action :run
	end

	execute "Install msg" do
	 cwd node['tds']['base']['path']
	 command "rpm -ivh idsldap-msg63-en-6.3.0-0.x86_64.rpm"
	 action :run
	end


	#######################################
	#
	# Delete unzip file
	#
	########################################

	log "-------------DST remove cache directory-----------"

	directory node['tds']['config']['mount'] do
	  owner "root"
	  group "root"
	  recursive true
	  action :delete
	end   

else
  log "Tivoli Directory Server 6.3 is already installed on this machine." do
  level :info
  end
end

