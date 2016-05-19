#
# AIX
#
# Basic
case node['platform_family']
when 'aix'

# Installers
  default['im']['zip']['file']      = "agent.installer.linux.gtk.x86_64_1.6.3001.20130528_1750.zip"
  default['im']['zip']['url']       = "/install/AIX/MIDDLEWARE/WAS/InstallationManager/1.7.0/agent.installer.aix.gtk.ppc_1.7.0.20130828_2012.zip"
  default['im']['install']['path']  = "/opt/IBM/InstallationManager/eclipse/tools"
  default['im']['lib']['path']      = "/var/ibm/InstallationManager"
  default['im']['shared_dir']       = "/DST/im/"

end