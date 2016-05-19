#
# RHEL
#
# Basic
case node['platform_family']
when 'rhel'

# Installers
  default['im_173']['zip']['file'] = "agent.installer.linux.gtk.x86_64_1.7.3000.20140521_1925.zip"
  default['im_173']['zip']['url'] = "/install/CHEF_FILES/IM/agent.installer.linux.gtk.x86_64_1.7.3000.20140521_1925.zip"
  default['im_173']['install']['path'] = "/opt/IBM/InstallationManager/eclipse/tools"
  default['im_173']['lib']['path'] = "/var/ibm/InstallationManager"
  default['im_173']['shared_dir'] = "/DST/im_v173/"
  default['im_173']['ibm_shared_dir'] = "/opt/IBM/IMShared"
end