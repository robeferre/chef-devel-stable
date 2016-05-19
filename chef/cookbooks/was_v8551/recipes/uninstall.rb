##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################
#
# Author:  Roberto Ferreira Junior
# Contact: rfjunior@br.ibm.com
#
##########################################################################################################

IM_INSTALL_LOCATION     = node['im']['installation']['path']
WAS_BASE_INSTALLATION   = node['was85']['installation']['path']
platform_family = node['platform_family']

if platform_family == "rhel"
  
  execute "Uninstalling WAS_v8.5.5.1" do
    user "root"
    command "/opt/IBM/WebSphere/AppServer/bin/stopServer.sh server1 &&\
             /opt/IBM/InstallationManager/eclipse/tools/imcl uninstall com.ibm.websphere.ND.v85_8.5.5001.20131018_2242 &&\
             rm -rf /opt/IBM/WebSphere/AppServer"
    action :run
  end
      
elsif platform_family == "aix"
  
  execute "Uninstalling WAS_v8.5.5.1" do
    user "root"
    command "/usr/IBM/WebSphere/AppServer/bin/stopServer.sh server1 &&\
             /opt/IBM/InstallationManager/eclipse/tools/imcl uninstall com.ibm.websphere.ND.v85_8.5.5001.20131018_2242 &&\
             rm -rf /opt/IBM/WebSphere/AppServer"
    action :run
  end
  
elsif platform_family == "windows"

  execute "Stoping WAS Server" do
     cwd WAS_BASE_INSTALLATION
     command "stopServer.bat server1"
     action :run
  end
  
  execute "Uninstalling WAS v8.5.5.1" do
     cwd IM_INSTALL_LOCATION
     command "imcl uninstall com.ibm.websphere.ND.v85_8.5.5001.20131018_2242"
     action :run
  end
  
  execute "Deleting folders" do
    command 'rd "C:/Program Files (x86)/IBM/WebSphere/AppServer" /s /q'
    action :run
  end
    
end