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


platform_family = node['platform_family']

if platform_family == "rhel"
  
  execute "Uninstalling WAS Liberty 8.5.5" do
    user "root"
    command "/opt/IBM/InstallationManager/eclipse/tools/imcl uninstall com.ibm.websphere.liberty.v85_8.5.5000.20130514_1313 &&\
             rm -rf /opt/IBM/WebSphere/Liberty"
    action :run
  end
  
elsif platform_family == "aix"
  execute "Uninstalling WAS Liberty 8.5.5" do
    user "root"
    command "/opt/IBM/InstallationManager/eclipse/tools/imcl uninstall com.ibm.websphere.liberty.v85_8.5.5000.20130514_1313 &&\
             rm -rf /usr/IBM/WebSphere/Liberty"
    action :run
  end
elsif platform_family == "windows"
end