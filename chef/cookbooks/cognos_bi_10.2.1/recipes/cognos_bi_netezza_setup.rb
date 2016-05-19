nz_package_file = Chef::Config[:file_cache_path] + "/" + node['cognos1021']['netezza']['pkg_file']
nz_dynamic_url = "http://#{$BEST_SERVER}#{node['cognos1021']['netezza']['client_url']}"
nz_installer_path = node['cognos1021']['netezza']['cache_dir'] + "/linux"
nz_odbcini_path = node['cognos1021']['netezza']['odbc_ini']
nz_odbcinstini_path = node['cognos1021']['netezza']['odbcinst_ini']
cognos_bi_bin_path = node['cognos1021']['base_install'] + "/bin64"

	# Stop application instances
	execute "Stopping Cognos BI ..." do
	  user "root"
	  cwd cognos_bi_bin_path
	  returns [0,2]
	  command "./cogconfig.sh -stop"
	  action :run
	end

	log "Creating Netezza client cache dir ..."
	directory node['cognos1021']['netezza']['cache_dir'] do
	  owner "root"
	  group "root"
	  mode "0777"
	  action :create
	  recursive true
	end   

	log "Downloading Netezza Client package ..." 
	remote_file nz_package_file do
	  source nz_dynamic_url
	  action :create_if_missing
	end

	# Uncompressing the installation files
	execute "Uncompressing the Netezza client pkg ..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "tar -xvf #{nz_package_file} -C #{node['cognos1021']['netezza']['cache_dir']}"
	  action :run
	end

	execute "Changing group permissions from nztools directory..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "chown root.root #{node['cognos1021']['netezza']['cache_dir']} -R"
	  action :run
	end

	# Uncompressing nzclient files
	execute "Installing Netezza client ..." do
	  user "root"
	  group "root"
	  cwd nz_installer_path
	  command "./unpack -f /usr/local/nz"
	  action :run
	end

	# Grant permissions to /usr/local/nz
	execute "Changing user permissions from /usr/local/nz ..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "chmod 777 /usr/local/nz -R"
	  action :run
	end

	execute "Changing group permissions from /usr/local/nz ..." do
	  user "root"
	  cwd Chef::Config[:file_cache_path]
	  command "chown root.root /usr/local/nz -R"
	  action :run
	end

  	# Installing the unixODBC library
  	execute "Installing the unixODBC.i686 library" do
      user "root"
      command "yum -y install unixODBC.i686"
      action :run
    end

	# Including nz root folder to the global libraries path
	execute "Setting up ld.so.conf to include /usr/local/nz/lib/ ..." do
  	  cwd Chef::Config[:file_cache_path]
  	  command "echo '/usr/local/nz/lib' >> /etc/ld.so.conf"
  	  action :run
	end

	execute "Running ldconfig..." do
  	  cwd Chef::Config[:file_cache_path]
  	  command "ldconfig"
  	  action :run
	end

    # Including nz client root folder to also be exported in LD_LIBRARY_PATH
	execute "Creating a new enviroment variable LD_LIBRARY to root ..." do
  	  user "root"
  	  cwd Chef::Config[:file_cache_path]
  	  command "echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/nz/lib' >> /root/.bash_profile"
  	  action :run
	end

	# Distribute libraries
	bash "Distributing nzjdbc3.jar libodbc.so libodbcinst.so libraries ..." do
      cwd Chef::Config[:file_cache_path]
	  user "root"
	  code <<-EOH
	  cp /usr/local/nz/lib/nzjdbc3.jar /opt/ibm/cognos/c10_64/v5dataserver/lib/
	  cp /usr/local/nz/lib/nzjdbc3.jar /opt/ibm/cognos/c10_64/webapps/p2pd/WEB-INF/lib/
	  cp /usr/lib/libodbc.so /usr/local/nz/lib
	  cp /usr/lib/libodbcinst.so /usr/local/nz/lib
	  EOH
	end

	# Create .odbc.ini and .odbcinst.ini into /root
	template nz_odbcini_path do
	  source "odbc.ini.erb"	
	  owner 'root'
	  group 'root'
	  mode '0777'
	  action :touch
	end

	template nz_odbcinstini_path do
	  source "odbcinst.ini.erb"	
	  owner 'root'
	  group 'root'
	  mode '0777'
	  action :touch
	end

	# Distribute libraries
	bash "Creating ODBCINI and NZ_ODBC_INI_PATH env variables to root ..." do
      cwd Chef::Config[:file_cache_path]
	  user "root"
	  code <<-EOH
	  echo 'export ODBCINI=/root/.odbc.ini' >> /root/.bash_profile
	  echo 'export NZ_ODBC_INI_PATH=/root/' >> /root/.bash_profile
	  EOH
	end

	# Restart application instances
	execute "Starting Cognos BI ..." do
	  user "root"
	  cwd cognos_bi_bin_path
	  command "./cogconfig.sh -s"
	  action :run
	end