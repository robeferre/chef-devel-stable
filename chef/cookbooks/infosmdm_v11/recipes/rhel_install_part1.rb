include_recipe 'was_v8552::install'
#include_recipe 'websphere_MQ_7503::mq7503_rhel_server'
include_recipe 'im_173::rhel_update'
include_recipe 'db2_ese_v105::server_install'

  ###########
  # Create and Setup a WAS Profile and Node
  ###########

  log "Setting up a WAS Profile and Node ..." 
  include_recipe "infosmdm_v11::rhel_was_profile_creation"



  ###########
  # Create and Configure the MDM database
  ###########

  log "Creating and Setting up the MDM database ..." 

  # # Prepare the sql files
  template db2_createdb_sql_path do
    source "create_db_db2.sql.erb"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end

  template db2_createts_sql_path do
    source "create_ts_db2.sql.erb"
    user "db2inst1"
    group "dasadm1"
    mode   '0600'
    action :touch
  end


  # # Call the recipe (run the sql commands)
  include_recipe "infosmdm_v11::rhel_db2_setup"