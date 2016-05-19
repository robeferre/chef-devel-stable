# Cookbook Name:: wlp
# Attributes:: default
#
# (C) Copyright IBM Corporation 2013.
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

#<> User name under which the server will be installed and running.
default[:wlp][:user] = "wlp"

#<> Group name under which the server will be installed and running.
default[:wlp][:group] = "wlp-admin"

#<
# Use the `java` cookbook to install Java. If Java is installed in a different manner 
# set it to `false`. The Java executables must be available on the __PATH__. 
#>  
default[:wlp][:install_java] = false

#<> Base installation directory.
default[:wlp][:base_dir] = "/opt/was/liberty"

#<> Set user configuration directory (wlp.user.dir). Set to 'nil' to use default location.
default[:wlp][:user_dir] = nil

#<> Installation method. Set it to 'archive' or 'zip'.
default[:wlp][:install_method] = 'archive'

#<
# Base URL location for downloading the runtime, extended, and extras Liberty profile archives. 
# Must be set when `node[:wlp][:install_method]` is set to `archive`. 
#>

default[:wlp][:archive][:base_url]                = "/install/WebSphere/WASND/liberty-beta-march2014"

#<> URL location of the runtime archive.
default[:wlp][:archive][:runtime][:url]           = "/wlp-beta-runtime-2014.3.0.0.jar"

#<> Checksum value for the runtime archive.
default[:wlp][:archive][:runtime][:checksum]      = 'df6e4cf78f91745a11372f1b4a8467fea8e7c53ddec48471cf92729deb88d306'
                                                
#<> URL location of the extended archive.
default[:wlp][:archive][:extended][:url]          = "/wlp-beta-extended-2014.3.0.0.jar"

#<> Checksum value for the extended archive.
default[:wlp][:archive][:extended][:checksum]     = '6589bb331bd38ec3d1f7af7bbfceae7f5682d62de155f0ca1b0076d47edad20a'

#<> Controls whether the extended archive should be downloaded and installed.
default[:wlp][:archive][:extended][:install]      = true

#<> URL location of the extras archive.
default[:wlp][:archive][:extras][:url]            = "/wlp-developers-extras-8.5.5.1.jar"
  
#<> Checksum value for the extras archive.
default[:wlp][:archive][:extras][:checksum]       = 'c468247e18ffb85b1d691f67839471ccd4390b299eb997151f7b56efc6332f4d'

#<> Controls whether the extras archive should be downloaded and installed.
default[:wlp][:archive][:extras][:install]        = false

#<> Base installation directory of the extras archive. 
default[:wlp][:archive][:extras][:base_dir]       =  "#{node[:wlp][:base_dir]}/extras"

#<
# Accept license terms when doing archive-based installation. 
# Must be set to `true` otherwise installation will fail. 
#>
default[:wlp][:archive][:accept_license] = true

#<
# URL location to a zip file containing Liberty profile installation files. Must be set 
# only when `node[:wlp][:install_method]` is set to `zip`.
#>
default[:wlp][:zip][:url] = nil

#<> Defines basic server configuration when creating server instances using the `wlp_server` resource.
default[:wlp][:config][:basic] = {
  "featureManager" => {
    "feature" => [ "jsp-2.2" ]
  },
  "httpEndpoint" => {
    "id" => "defaultHttpEndpoint",
    "host" => "*",
    "httpPort" => "9080",
    "httpsPort" => "9443"
  }
}
