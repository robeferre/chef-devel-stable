##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################

# Author:: Daniel Abrao (<dasc@br.ibm.com>)
#          Roberto Ferreira Junior (<rfjunior@br.ibm.com>)
#
# Cookbook:: IBM Network Handler
# Library:: network_helper

# installing basic gems
 chef_gem "net-ping-1.7.4.gem" do
  source  node['ibm']['network']['gems_repository'] + "net-ping-1.7.4.gem"
  version "1.7.4"
  action  :install
 end


case node['platform_family']
when 'windows'
# gems for windows
 chef_gem "win32-security-0.2.5.gem" do
  source  node['ibm']['network']['gems_repository'] + "win32-security-0.2.5.gem"
  version "0.2.5"
  action :install
 end
end

require 'net/ping'

$BEST_SERVER = better_server()

log "The BEST server found: #{$BEST_SERVER}"