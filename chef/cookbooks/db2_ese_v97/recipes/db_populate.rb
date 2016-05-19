################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v97
# Recipe:: create
#
populate_script = "/tmp/populate_db2_db.sql"

USER = "root"
CONFIG_MOUNT = node['config']['mount']
DB2_GZIP_LOCATION = node['db2']['gzip']['location']
DB2_RESPONSE_LOCATION = node['db2']['response']['location']
DB2_GZIP_FILE = node['db2']['gzip']['file']
DB2_TAR_FILE = node['db2']['tar']['file']
DB2_LOG_FILE = node['db2']['log']['file']
DB2_RESPONSE_FILE = node['db2']['response']['file']
DB2_ESE_LOCATION = "#{CONFIG_MOUNT}" + "/db2-v97-ese-x64"
DB2_DATABASE_NAME = node['jke']['db_name']
DB2_SCRIPT_LOCATION = node['jke']['script']['location']
DB2_SCRIPT_NAME = node['jke']['script']['name']
DB2_USER_NAME = node['jke']['user']['name']

execute "Change Owner" do
  user "root"
  cwd "#{CONFIG_MOUNT}"
  command "chown db2inst1.db2iadm1 populate_db2_db.sql"
  action :run
end

execute "Change Permissions" do
  user "root"
  cwd "#{CONFIG_MOUNT}"
  command "chmod 777 populate_db2_db.sql"
  action :run
end

script "create_tables" do 
  interpreter "bash"
  user DB2_USER_NAME
  cwd "#{CONFIG_CACHE}"
  code <<-EOH
   . /home/#{DB2_USER_NAME}/sqllib/db2profile
   /home/#{DB2_USER_NAME}/sqllib/bin/db2batch -d #{DB2_DATABASE_NAME} -f populate_db2_db.sql
  EOH
end
