log "-------------DST Create the directory cache path #{node['p8db']['config']['mount']}-----------"
 
	directory node['p8db']['config']['mount'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 action :create
	end 
log "-------------DST Create the directory cache path #{node['p8db']['cache']}-----------"
 
	directory node['p8db']['cache'] do
	 owner "root"
	 group "root"
	 mode "0755"
	 recursive true
	 action :create
	end 

  ###################################################
  # Create and Configure the filnet database
  ###################################################

  # log "Creating and Setting up the filenet database ..." 

  # # Prepare the sql files
  template "#{node['p8db']['cache']}/#{node['p8db']['rspdb']['file']}" do
    source "#{node['p8db']['rspdb']['erb']}"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end

  template "#{node['p8db']['cache']}/#{node['p8db']['rspts']['file']}" do
    source "#{node['p8db']['rspts']['erb']}"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end

create_db_file = node['p8db']['cache'] + "/create_db_db2.sql"
create_ts_file = node['p8db']['cache'] + "/create_ts_db2.sql"

########################################################
# create Database and Tablespace.
########################################################

# Execute sql to create FileNet database
execute "Creating Filenet database ... " do
  user "db2inst1"
  group "dasadm1"
  cwd node['p8db']['db2_home']
  command "/home/db2inst1/sqllib/bin/db2 -tvf #{create_db_file}"
  action :run
end


# Execute sql to prepare FileNet GCD database tablespaces
execute "Creating Filenet GCD tablespaces ... " do
  user "db2inst1"
  group "dasadm1"
  returns [0,4]
  cwd node['p8db']['db2_home']
  command "/home/db2inst1/sqllib/bin/db2 -tvf  #{create_ts_file}"
  action :run
end

#######################################
#
# Delete unzip file
#
########################################

log "-------------DST remove cache directory-----------"

directory node['p8db']['config']['mount'] do
  owner "root"
  group "root"
  recursive true
  action :delete
end   
