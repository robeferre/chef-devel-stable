#
# RHEL
#
# Basic
case node['platform_family']
when 'rhel'

# Installers
  default['im']['zip']['file'] = "agent.installer.linux.gtk.x86_64_1.6.3001.20130528_1750.zip"
  default['im']['zip']['url'] = "/install/CHEF_FILES/IM/agent.installer.linux.gtk.x86_64_1.6.3001.20130528_1750.zip"
  default['im']['install']['path'] = "/opt/IBM/InstallationManager/eclipse/tools"
  default['im']['lib']['path'] = "/var/ibm/InstallationManager"
  default['im']['shared_dir'] = "/DST/im/"
end