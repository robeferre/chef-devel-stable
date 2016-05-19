###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
ihs_dynamic_url_file = "http://#{$BEST_SERVER}#{node['mq7103']['zip']['location']}"
#######################################
#
# create Cache_path for Websphere MQ
#
#######################################

if (!(File.directory?(node['mq7103']['base']['path'])))

	log "---DST - Create the directory #{node['mq7103']['config']['mount']}----" 
 
	directory node['mq7103']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
	log "----DST - Create the directory #{node['mq7103']['config']['cache']}----" 

	directory node['mq7103']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  

	##################################
	#
	# copy /install in cache_path
	#
	##################################
	log "-----DST - Get the Websphere MQ V7103 zip 1 file----"

	remote_file "#{node['mq7103']['config']['mount']}/#{node['mq7103']['zip']['file1']}" do
	source ihs_dynamic_url_file
	action :create_if_missing
	end
	
	################################
	#
	# unzip install files
	#
	################################
	
	log "---- DST - Unzip the Websphere MQ zip file 1----" 

	windows_zipfile "#{node['mq7103']['config']['cache']}" do
	  source "#{node['mq7103']['config']['mount']}/#{node['mq7103']['zip']['file1']}"
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

	
	windows_package 'mq_7103 install' do
	source node['mq7103']['config']['cache'] + '/MSI/' + "IBM WebSphere MQ.msi"
	options '/l*v c:\\install.log /qn ADDLOCAL="Server,Client,Explorer,JavaMsg,Toolkit" PGMFOLDER="c:\mqm" AGREETOLICENSE="yes" REMOVEFEATURES="yes" LAUNCHWIZ="0"'
	installer_type :custom
	action :install
	end

	log "----DST - set it as the primary installation ----" 

	execute "Set it as primary installation" do
	 cwd node['mq7103']['base']['path'] + "/bin/"
	 command "setmqinst.exe -i -p c:\\mqm "
	 action :run
	end
	
	log "----DST - change the startup type of service by auto ---"

	execute "change the startup type" do
	cwd node['mq7103']['base']['path']
	command "sc config MQ_Installation1 start= auto"
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
	directory node['mq7103']['config']['mount'] do
	  recursive true
	  action :delete
	end   
else

  log "IBM Websphere MQ Server is already installed!" do
  level :info
  end

end

