#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: sql_server
# Recipe:: server
#
# Copyright:: 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'windows'
include_recipe 'openssl'
include_recipe '7-zip-master'

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

SQL_SERVER_INSTALL_LOCATION  = node['sql_server']['install_dir']    #'C:\Program Files\Microsoft SQL Server'
SQL_SERVER_INSTANCE_LOCATION = node['sql_server']['instance_dir']   #'C:\Program Files\Microsoft SQL Server'

CACHE_PATH = Chef::Config[:file_cache_path]
SQL_SERVER_BASE_LOCATION     = "#{CACHE_PATH}"+"/sql_server_installation_files"

# ZIP_INSTALLATION_FILES
SQL_SERVER_ZIP1_URL = node['sql_server']['server']['setup_ZIP1']['url']
SQL_SERVER_ZIP1_FILE = node['sql_server']['server']['setup_ZIP1']['package_name']
SQL_SERVER_ZIP2_URL = node['sql_server']['server']['setup_ZIP2']['url']
SQL_SERVER_ZIP2_FILE = node['sql_server']['server']['setup_ZIP2']['package_name']
SQL_SERVER_ZIP3_URL = node['sql_server']['server']['setup_ZIP3']['url']
SQL_SERVER_ZIP3_FILE = node['sql_server']['server']['setup_ZIP3']['package_name']
SQL_SERVER_ZIP4_URL = node['sql_server']['server']['setup_ZIP4']['url']
SQL_SERVER_ZIP4_FILE = node['sql_server']['server']['setup_ZIP4']['package_name']
SQL_SERVER_ZIP5_URL = node['sql_server']['server']['setup_ZIP5']['url']
SQL_SERVER_ZIP5_FILE = node['sql_server']['server']['setup_ZIP5']['package_name']
SQL_SERVER_ZIP6_URL = node['sql_server']['server']['setup_ZIP6']['url']
SQL_SERVER_ZIP6_FILE = node['sql_server']['server']['setup_ZIP6']['package_name']
SQL_SERVER_ZIP7_URL = node['sql_server']['server']['setup_ZIP7']['url']
SQL_SERVER_ZIP7_FILE = node['sql_server']['server']['setup_ZIP7']['package_name']

######################
##   INSTALLATION   ##
######################

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}") && File.directory?("#{SQL_SERVER_BASE_LOCATION}")))
    ruby_block "hack to mkdir on windows" do
      block do
          require 'fileutils'
          FileUtils.mkdir_p "#{SQL_SERVER_BASE_LOCATION}"
      end
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP1_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP1_FILE}" do
       source SQL_SERVER_ZIP1_URL
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}//#{SQL_SERVER_ZIP2_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP2_FILE}" do
       source SQL_SERVER_ZIP2_URL
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP3_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP3_FILE}" do
       source SQL_SERVER_ZIP3_URL
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP4_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP4_FILE}" do
       source SQL_SERVER_ZIP4_URL
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP1_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP5_FILE}" do
       source SQL_SERVER_ZIP5_URL
    end
end 

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP6_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP6_FILE}" do
       source SQL_SERVER_ZIP6_URL
    end
end

if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP7_FILE}")))
    remote_file "#{SQL_SERVER_BASE_LOCATION}/#{SQL_SERVER_ZIP7_FILE}" do
       source SQL_SERVER_ZIP7_URL
    end
end

# Unzip files using 7zip
if (!(File.exists?("#{SQL_SERVER_BASE_LOCATION}/MSSQLSRV2008DEV_FILES") && File.directory?("#{SQL_SERVER_BASE_LOCATION}/MSSQLSRV2008DEV_FILES")))
  execute "7zip all splited packages" do
    cwd      "#{SQL_SERVER_BASE_LOCATION}" 
    command  'c:\7-zip\7z x MSSQLSRV2008DEV_FILES.zip.001'   
    action   :run
  end
end

service_name = node['sql_server']['instance_name']
if node['sql_server']['instance_name'] == 'MSSQLSERVERDEV'
  service_name = "MSSQL$#{node['sql_server']['instance_name']}"
end

config_file_path = win_friendly_path(File.join("#{SQL_SERVER_BASE_LOCATION}", "ConfigurationFile.ini"))

template config_file_path do
  source "ConfigurationFile.ini.erb"
  action :touch
end

execute "Install Sql Server 2008 R2 Developer Edition" do
  cwd "#{SQL_SERVER_BASE_LOCATION}"+'\MSSQLSRV2008DEV_FILES' 
  command 'setup.exe /ConfigurationFile="'+'c:\tmp\chef-solo\sql_server_installation_files\ConfigurationFile.ini"'
  action :run
end

service service_name do
  action :nothing
end

execute "Delete Files" do
  command 'rd c:\tmp\chef-solo\sql_server_installation_files /q /s'
  action :run
end

include_recipe 'sql_server::client'