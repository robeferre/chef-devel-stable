#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: sql_server
# Attribute:: server
#
# Copyright:: Copyright (c) 2011 Opscode, Inc.
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
#
default['sql_server']['install_dir']    = 'C:\Program Files\Microsoft SQL Server'
default['sql_server']['port']           = 1433
default['sql_server']['instance_name']  = 'MSSQLSERVERDEV'
default['sql_server']['instance_dir']   = 'C:\Program Files\Microsoft SQL Server'
default['sql_server']['feature_list']   = 'SQLENGINE,REPLICATION,SNAC_SDK,CONN,SSMS,ADV_SSMS,Tools,FULLTEXT'

#ZIP FILES 
default['sql_server']['server']['setup_ZIP1']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.001'
default['sql_server']['server']['setup_ZIP1']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP1']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.001'

default['sql_server']['server']['setup_ZIP2']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.002'
default['sql_server']['server']['setup_ZIP2']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP2']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.002'

default['sql_server']['server']['setup_ZIP3']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.003'
default['sql_server']['server']['setup_ZIP3']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP3']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.003'

default['sql_server']['server']['setup_ZIP4']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.004'
default['sql_server']['server']['setup_ZIP4']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP4']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.004'

default['sql_server']['server']['setup_ZIP5']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.005'
default['sql_server']['server']['setup_ZIP5']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP5']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.005'

default['sql_server']['server']['setup_ZIP6']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.006'
default['sql_server']['server']['setup_ZIP6']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP6']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.006'

default['sql_server']['server']['setup_ZIP7']['url']         = 'http://dst.lexington.ibm.com/install/CHEF_FILES/SQL_SERVER_2008_R2/MSSQLSRV2008DEV_FILES.zip.007'
default['sql_server']['server']['setup_ZIP7']['checksum']     = '6840255cf493927a3f5e1d7f865b8409ed89133e3657a609da229bab4005b613'
default['sql_server']['server']['setup_ZIP7']['package_name'] = 'MSSQLSRV2008DEV_FILES.zip.007'

# .NET
default['sql_server']['server']['dotnet_framework']['url']          = 'http://download.microsoft.com/download/0/6/1/061F001C-8752-4600-A198-53214C69B51F/dotnetfx35setup.exe'
default['sql_server']['server']['dotnet_framework']['checksum']     = '6ba7399eda49212524560c767045c18301cd4360b521be2363dd77e23da3cf36' #SHA 256
default['sql_server']['server']['dotnet_framework']['package_name'] = 'Microsoft .NET Framework 3.5 Service Pack 1'

# Management Studio
default['sql_server']['server']['manage_studio']['url']          = 'http://download.microsoft.com/download/6/7/4/674A281B-84BF-4B49-848C-14873B22F977/SQLManagementStudio_x64_ENU.exe'
default['sql_server']['server']['manage_studio']['checksum']     = '31d23f9189c816d9532adfb1a391937f255c5acea6bc54326a202d583afc6258' #SHA 256
default['sql_server']['server']['manage_studio']['package_name'] = 'SQL Management Studio 2008 ENU (64-bit)'