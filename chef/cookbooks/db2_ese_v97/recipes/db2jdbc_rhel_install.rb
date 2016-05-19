################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
#
# Cookbook Name:: db2_ese_v97
# Recipe:: db2jdbc
# Made by: dasc@br.ibm.com (Daniel Abraão - Applicatoin Developer/DST Scripts)

dynamic_url = "http://#{$BEST_SERVER}#{node['db2']['jdbc']['url']}"

# Creating tmp dir
directory node['db2']['jdbc']['tmpdir'] do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
     not_if { File.exists?node['db2']['jdbc']['tmpdir']}
end

# Check if the DB2 main installation dir exists
if (!File.exists?(node['db2']['jdbc']['path']))
  directory node['db2']['jdbc']['path'] do
     owner "root"
     group "root"
     mode "0755"
     recursive true
     action :create
  end   
end

# Get the DB2 Libdb2JDBC
execute "Get db2jdbc file" do
  user "root"
  cwd node['db2']['jdbc']['tmpdir']
  command "wget #{dynamic_url}"
  action :run
  umask 0666
end


# Making backup if the files already exists
if (!(File.exists?(node['db2']['jdbc']['file']) or File.directory?(node['db2']['jdbc']['link'])))
  execute 'backuping libdb2jdbc.so.1 tmp' do
   command "cp #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['file']} #{node['db2']['jdbc']['tmpdir']}/bkp_#{node['db2']['jdbc']['file']}"
   action :run
  end

  execute 'backuping libdb2jdbc.so.1 path' do
   command "cp #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['file']} #{node['db2']['jdbc']['path']}/bkp_#{node['db2']['jdbc']['file']}"
   action :run
  end

  execute 'backuping libdb2jdbc.so tmp' do
   command "cp #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['link']} #{node['db2']['jdbc']['tmpdir']}/bkp_#{node['db2']['jdbc']['link']}"
   action :run
  end

  execute 'backuping libdb2jdbc.so path' do
   command "cp #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['link']} #{node['db2']['jdbc']['path']}/bkp_#{node['db2']['jdbc']['link']}"
   action :run
  end

end


# Removing old files
  execute 'removing libdb2jdbc.so' do
   command "rm -f #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['link']}"
   action :run
  end
   
  execute 'removing libdb2jdbc.so.1' do
   command "rm -f #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['file']}"
   action :run
  end


# Creating new ones
  execute 'creating libdb2jdbc.so.1' do
   command "cp /tmp/db2jdbc/#{node['db2']['jdbc']['file']} #{node['db2']['jdbc']['path']}"
   action :run
  end

  execute 'creating libdb2jdbc.so' do
   command "ln -s #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['file']} #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['link']}"
   action :run
  end

  execute 'adjusting permissions for libdb2jdbc.so' do
   command "chmod 0555 #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['file']}"
   action :run
  end

  execute 'adjusting permissions for libdb2jdbc.so.1' do
   command "chmod 0555 #{node['db2']['jdbc']['path']}/#{node['db2']['jdbc']['link']}"
   action :run
  end

