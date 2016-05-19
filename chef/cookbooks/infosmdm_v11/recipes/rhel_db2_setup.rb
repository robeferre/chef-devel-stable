create_db_file = node['infosmdm']['cache'] + "/create_db_db2.sql"
create_ts_file = node['infosmdm']['cache'] + "/create_ts_db2.sql"

# Execute sql to create MDM database
execute "Creating MDM11DB database ... " do
  user "db2inst1"
  group "dasadm1"
  cwd node['infosmdm']['db2_home']
  command "/home/db2inst1/sqllib/bin/db2 -tvf #{create_db_file}"
  action :run
end


# Execute sql to prepare MDM database tablespaces
execute "Creating MDM11DB tablespaces ... " do
  user "db2inst1"
  group "dasadm1"
  returns [0,4]
  cwd node['infosmdm']['db2_home']
  command "/home/db2inst1/sqllib/bin/db2 -tvf #{create_ts_file}"
  action :run
end