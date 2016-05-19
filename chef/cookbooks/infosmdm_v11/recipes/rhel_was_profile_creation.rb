was_bin_path = node['infosmdm']['was_bin_path']
was_dmgr01_path = node['infosmdm']['was_dmgr01_path']
was_dmgr01_bin_path = node['infosmdm']['was_dmgr01_path'] + "/bin"
was_dmgr01_user = node['infosmdm']['was_profile_usr']
was_dmgr01_passwd = node['infosmdm']['was_profile_pw']
# was_node02_path = node['infosmdm']['was_node02_path']
# was_node02_bin_path = node['infosmdm']['was_node02_path'] + "/bin"

full_name = "#{node['fqdn']}"
host_name = "#{node['hostname']}"
domain_name = "#{node['domain']}"

  # Stop server1 default 
  execute "Stopping server1 ... " do
    user "root"
    group "root"
    returns [0,255,246]
    cwd was_bin_path
    command "./stopServer.sh server1"
    action :run
  end


  # Adding wasadmin user
  execute "Adding user wasadmin" do
    user "root"
    command "useradd wsadmin -m -p 'Sn3tzLuiwAP9Q'"
    action :run
    not_if "grep wsadmin /etc/passwd"
  end


  # Create Deployment Manager Profile
  execute "Creating Dmgr01 profile into #{was_dmgr01_path}" do
    user "root"
    group "root"
    cwd was_bin_path
    command "./manageprofiles.sh -create -profileName Dmgr01 -profilePath #{was_dmgr01_path} -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/management -serverType DEPLOYMENT_MANAGER -enableAdminSecurity true -adminUserName #{was_dmgr01_user} -adminPassword #{was_dmgr01_passwd}"
    action :run
    not_if "ls -lhar #{was_dmgr01_path}"
  end

  # Start Deployment Manager
  execute "Starting deployment manager ... " do
    user "root"
    group "root"
    cwd was_bin_path
    command "./startManager.sh -profileName Dmgr01"
    action :run
  end


 # Create Application Server Profile
  # execute "Creating Node02 into #{was_node02_path}" do
  #   user "root"
  #   group "root"
  #   cwd was_bin_path
  #   command "./manageprofiles.sh -create -profileName Node02 -profilePath #{was_node02_path} -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default -nodeName #{host_name}Node02 -cellName #{host_name}Cell02 -federateLater false -dmgrAdminUserName #{was_dmgr01_user} -dmgrAdminPassword #{was_dmgr01_passwd} -dmgrHost #{full_name} -dmgrPort 8879"
  #   action :run
  #   not_if "ls -lhar #{was_node02_path}"
  # end

  # # Add node
  execute "Adding AppSrv01 node ... " do
    user "root"
    group "root"
    cwd was_bin_path
    command "./addNode.sh #{host_name} 8879 -profileName AppSrv01 -username #{was_dmgr01_user} -password #{was_dmgr01_passwd}"
    action :run
  end

#---------
 # #  # Stop Application Server Node
 #  execute "Stopping WAS Node02 ... " do
 #    user "root"
 #    group "root"
 #    returns [0, 255]
 #    cwd was_node02_bin_path
 #    command "./stopNode.sh -username mdmadmin -password dst4you"
 #    action :run
 #  end

 # #  # Start Application Server Node
 #  execute "Starting WAS Node02 ... " do
 #    user "root"
 #    group "root"
 #    cwd was_bin_path
 #    command "./startNode.sh -profileName Node02"
 #    action :run
 #  end
#---------
  # Start Server 
  execute "Starting Server server1 ... " do
    user "root"
    group "root"
    cwd was_bin_path
    command "./startServer.sh -profileName AppSrv01 server1"
    action :run
  end

#-------------

 # Create unmanaged profile
  # execute "Starting WAS Node02 ... " do
  #  user "root"
  #  group "root"
  #  cwd was_bin_path
  #  command "  ./manageprofiles.sh -create -profileName server1 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default -federateLater false -dmgrAdminUser mdmadmin -enableAdminSecurity true -adminUserName mdmadmin -adminPassword dst4you"
  #  action :run
  # end


  
  # Comment AppSrv01 default startup process
  # execute "Commeting the /etc/rc.local AppSrv01 entry ... " do
  #   user "root"
  #   group "root"
  #   command "sed -e '/opt/ s/^#*/#/' -i /etc/rc.local"
  #   action :run
  #   not_if "grep '#/opt/IBM/WebSphere/AppServer/bin/startServer.sh server1 -profileName AppSrv01' /etc/rc.local"
  # end

  # # Include a new entry
  # execute "Including a simpleServer startup call to rc.local ..." do
  #   user "root"
  #   group "root"
  #   cwd was_bin_path
  #   command "echo #{was_bin_path}/startServer.sh server1 -profileName Ǹode02 >> /etc/rc.local"
  #   action :run
  #   not_if "grep Node02 /etc/rc.local"
  # end