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

=begin
#<
Installs WebSphere Application Server Liberty Profile from jar archive files. 
This recipe is called by the `default` recipe and should not be used directly.
#>
=end

WLP_BASE_URL = "http://#{$BEST_SERVER}#{node[:wlp][:archive][:base_url]}"
WLP_RUNTIME_URL  = "#{WLP_BASE_URL}/wlp-beta-runtime-2014.3.0.0.jar"
WLP_EXT_RUNTIME_URL = "#{WLP_BASE_URL}/wlp-beta-extended-2014.3.0.0.jar"
WLP_EXTRAS_URL = "#{WLP_BASE_URL}/wlp-developers-extras-8.5.5.1.jar"



unless node[:wlp][:archive][:base_url]
  raise "You must specify the base URL location to download WebSphere Application Server Liberty Profile archives."
end

unless node[:wlp][:archive][:accept_license]
  raise "You must accept the license to install WebSphere Application Server Liberty Profile."
end

runtime_dir = "#{node[:wlp][:base_dir]}/wlp"
runtime_uri = ::URI.parse(node[:wlp][:archive][:runtime][:url])
runtime_filename = ::File.basename(runtime_uri.path)

# Fetch the WAS Liberty Profile runtime file
if runtime_uri.scheme == "file"
  runtime_file = runtime_uri.path
else
  runtime_file = "#{Chef::Config[:file_cache_path]}/#{runtime_filename}"
  remote_file runtime_file do
    source WLP_RUNTIME_URL
    user node[:wlp][:user]
    group node[:wlp][:group]
    checksum node[:wlp][:archive][:runtime][:checksum]
    not_if { ::File.exists?(runtime_dir) }
  end
end

# Used to determine whether extended archive is already installed
extended_dir = "#{node[:wlp][:base_dir]}/wlp/bin/jaxws"

# Fetch the WAS Liberty Profile extended content
if node[:wlp][:archive][:extended][:install]
  extended_uri = ::URI.parse(node[:wlp][:archive][:extended][:url])
  extended_filename = ::File.basename(extended_uri.path)

  if extended_uri.scheme == "file"
    extended_file = extended_uri.path
  else
    extended_file = "#{Chef::Config[:file_cache_path]}/#{extended_filename}"
    remote_file extended_file do
      source WLP_EXT_RUNTIME_URL
      user node[:wlp][:user]
      group node[:wlp][:group]
      checksum node[:wlp][:archive][:extended][:checksum]
      not_if { ::File.exists?(extended_dir) }
    end
  end
end

# Used to determine whether extras archive is already installed
extras_dir = "#{node[:wlp][:archive][:extras][:base_dir]}/wlp"

# Fetch the WAS Liberty Profile extras content
if node[:wlp][:archive][:extras][:install]
  extras_uri = ::URI.parse(node[:wlp][:archive][:extras][:url])
  extras_filename = ::File.basename(extras_uri.path)

  if extras_uri.scheme == "file"
    extras_file = extras_uri.path
  else
    extras_file = "#{Chef::Config[:file_cache_path]}/#{extras_filename}"
    remote_file extras_file do
      source WLP_EXTRAS_URL
      user node[:wlp][:user]
      group node[:wlp][:group]
      checksum node[:wlp][:archive][:extras][:checksum]
      not_if { ::File.exists?(extras_dir) }
    end
  end
end

# Install the WAS Liberty Profile
execute "install #{runtime_filename}" do
  cwd node[:wlp][:base_dir]
  command "java -jar #{runtime_file} --acceptLicense #{node[:wlp][:base_dir]}" 
  user node[:wlp][:user]
  group node[:wlp][:group]
  not_if { ::File.exists?(runtime_dir) }
end

# Install the WAS Liberty Profile extended content
if node[:wlp][:archive][:extended][:install]
  execute "install #{extended_filename}" do
    cwd node[:wlp][:base_dir]
    command "java -jar #{extended_file} --acceptLicense #{node[:wlp][:base_dir]}" 
    user node[:wlp][:user]
    group node[:wlp][:group]
    not_if { ::File.exists?(extended_dir) }
  end
end

# Install the WAS Liberty Profile extras
if node[:wlp][:archive][:extras][:install]
  directory node[:wlp][:archive][:extras][:base_dir] do
    user node[:wlp][:user]
    group node[:wlp][:group]
    mode "0755"
    recursive true
  end

  execute "install #{extras_filename}" do
    cwd node[:wlp][:archive][:extras][:base_dir]
    command "java -jar #{extras_file} --acceptLicense #{node[:wlp][:archive][:extras][:base_dir]}" 
    user node[:wlp][:user]
    group node[:wlp][:group]
    not_if { ::File.exists?(extras_dir) }
  end
end
