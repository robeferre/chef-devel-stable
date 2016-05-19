gs_db_tar_file = node['cognos1021']['smps']['datasource_file']
gs_db_unix_path = node['cognos1021']['smps']['db2_datasource'] + "/GS_DB/unix"

# Uncompressing GS_DB files to DB2
	execute "Uncompressing the Cognos BI Samples DB2 datasource ..." do
	  user "root"
	  cwd node['cognos1021']['smps']['db2_datasource']
	  command "tar -xvf #{gs_db_tar_file}"
	  action :run
	end

# Uncompressing GS_DB files to DB2
	execute "Changing permissions from datasources directory ..." do
	  user "root"
	  cwd node['cognos1021']['smps']['db2_datasource']
	  command "chmod 777 #{node['cognos1021']['smps']['db2_datasource']} -R"
	  action :run
	end

	# Loading GS_DB database
	bash "Loading GS_DB to DB2 ..." do
      cwd gs_db_unix_path
	  user "db2inst1"
	  code <<-EOH
	   cd #{gs_db_unix_path}
	   source /home/db2inst1/sqllib/db2profile
	   ./setupGSDB.sh -createdb -database GS_DB -userid db2inst1 -password dst4you -noprompt
	  EOH
	end