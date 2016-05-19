cognos_conf_path = node['cognos1021']['ihs']['conf_path'] + "/cognos.conf"
cognos_bi_bin_path = node['cognos1021']['base_install'] + "/bin64"
ihs_bin_path = node['cognos1021']['ihs']['base_path'] + "/bin"
ld_library_run = "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ibm/cognos/c10_64/cgi-bin:/opt/ibm/cognos/c10_64/cgi-bin/lib"
db2_jdbc_drivers_path = node['cognos1021']['db2_client']['jdbc_path']

# Stop application instances
execute "Stopping Cognos BI ..." do
  cwd cognos_bi_bin_path
  returns [0,2]
  command "./cogconfig.sh -stop"
  action :run
end

execute "Stopping HTTP Server ..." do
  returns [0,1,2]
  cwd ihs_bin_path
  command "./apachectl stop"
  action :run
end

# Create symbolic links as part of the Cogno setup
execute "Creating a symbolic link from libdb2.so.1 to /opt/ibm/cognos/c10_64/v5dataserver/lib/libdb2.so ..." do
  returns [0,1]
  cwd ihs_bin_path
  command "ln -s /home/db2inst1/sqllib/lib/libdb2.so.1 /opt/ibm/cognos/c10_64/v5dataserver/lib/libdb2.so"
  action :run
end

execute "Creating a symbolic link from libdb2.so.1 to /opt/ibm/cognos/c10_64/webapps/p2pd/WEB-INF/lib/libdb2.so ..." do
  returns [0,1]
  cwd ihs_bin_path
  command "ln -s /home/db2inst1/sqllib/lib/libdb2.so.1 /opt/ibm/cognos/c10_64/webapps/p2pd/WEB-INF/lib/libdb2.so"
  action :run
end

# Copy DB2 JDBC Drivers to the Cogos Installation
execute "Copying the DB2 JDBC drivers to /opt/ibm/cognos/c10_64/v5dataserver/lib/ ..." do
  cwd db2_jdbc_drivers_path
  command "cp db2jcc.jar db2jcc4.jar /opt/ibm/cognos/c10_64/v5dataserver/lib/"
  action :run
end

execute "Copying the DB2 JDBC drivers to /opt/ibm/cognos/c10_64/webapps/p2pd/WEB-INF/lib/" do
  cwd db2_jdbc_drivers_path
  command "cp db2jcc.jar db2jcc4.jar /opt/ibm/cognos/c10_64/webapps/p2pd/WEB-INF/lib/"
  action :run
end

# Creating the cognos.conf file
template cognos_conf_path do
  source "cognos.conf.erb"	
  owner 'root'
  group 'root'
  mode '0600'
  action :touch
end

# Including cognos.conf in the main configuration file
execute "Setting up the http.conf to include cognos.conf ..." do
  cwd Chef::Config[:file_cache_path]
  command "echo 'include /opt/IBM/HTTPServer/conf/cognos.conf' >> /opt/IBM/HTTPServer/conf/httpd.conf"
  action :run
end

# Including cognos.conf in the main configuration file
execute "Setting up ld.so.conf to include /opt/IBM/DB2/v10.5/lib32 ..." do
  cwd Chef::Config[:file_cache_path]
  command "echo '/opt/IBM/db2/V10.1/lib32/' >> /etc/ld.so.conf"
  action :run
end

# Including the cognos.conf in the main configuration file
execute "Running ldconfig..." do
  cwd Chef::Config[:file_cache_path]
  command "ldconfig"
  action :run
end

# Restart application instances
execute "Starting Cognos BI ..." do
  cwd cognos_bi_bin_path
  command "./cogconfig.sh -s"
  action :run
end

# Including cognos.conf in the main configuration file
execute "Creating a new enviroment variable LD_LIBRARY to root ..." do
  user "root"
  cwd Chef::Config[:file_cache_path]
  command "echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/ibm/cognos/c10_64/cgi-bin:/opt/ibm/cognos/c10_64/cgi-bin/lib' >> /root/.bash_profile"
  action :run
end

execute "Starting HTTP Server ..." do
  user "root"
  cwd ihs_bin_path
  command "#{ld_library_run};./apachectl start"
  action :run
end