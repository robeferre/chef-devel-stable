################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v97
# Recipe:: default
#

CONFIG_MOUNT = Chef::Config[:file_cache_path] + "/db2_install"
CONFIG_CACHE = Chef::Config[:file_cache_path] + "/db2_install/tmp"
DB2_GZIP_LOCATION = node['db2']['gzip']['location']
DB2_RESPONSE_LOCATION = node['db2']['response']['location']
DB2_GZIP_FILE = node['db2']['gzip']['file']
DB2_TAR_FILE = node['db2']['tar']['file']
DB2_LOG_FILE = node['db2']['log']['file']
DB2_RESPONSE_FILE = node['db2']['response']['file']
DB2_ESE_LOCATION = "#{CONFIG_CACHE}" + "/db2-v97-ese-x64"
DB2_DATABASE_NAME = node['jke']['db_name']
DB2_SCRIPT_LOCATION = node['jke']['script']['location']
DB2_SCRIPT_NAME = node['jke']['script']['name']
DB2_USER_NAME = node['jke']['user']['name']

# Create directory for config cache
if (!(File.exists?("#{CONFIG_CACHE}") && File.directory?("#{CONFIG_CACHE}")))
  directory "#{CONFIG_CACHE}" do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

# Get the DB2 ESE gzip file
execute "Get DB2 ESE File" do
  user "root"
  cwd CONFIG_CACHE
  command "wget #{DB2_GZIP_LOCATION}"
  action :run
end

# Get the DB2 ESE response file
execute "Get DB2 ESE Response File" do
  user "root"
  cwd CONFIG_MOUNT
  command "wget #{DB2_RESPONSE_LOCATION}"
  action :run
end

# Unzip the DB2 ESE tar ball
execute "Unzip DB2 ESE File" do
  user "root"
  cwd CONFIG_CACHE
  command "gunzip #{DB2_GZIP_FILE}"
  action :run
end

# Untar the DB2 ESE tar ball
execute "Untar DB2 ESE File" do
  user "root"
  cwd CONFIG_CACHE
  command "tar -xvf #{DB2_TAR_FILE}"
  action :run
end

# Install DB2 silently
execute "Install DB2 ESE" do
  user "root"
  cwd DB2_ESE_LOCATION
  command "#{DB2_ESE_LOCATION}/db2setup -l #{DB2_LOG_FILE} -r #{DB2_RESPONSE_FILE}"
  action :run
end

# Get the DB2 script
execute "Get DB2 script" do
  user "root"
  cwd CONFIG_CACHE
  command "wget #{DB2_SCRIPT_LOCATION}"
  action :run
end
