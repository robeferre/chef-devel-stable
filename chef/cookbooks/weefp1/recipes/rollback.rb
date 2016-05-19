#
# silent roll back of WorkLight FP1
# 

response_path = node['weefp1']['cache'] + "/weefp1_rollback.rsp"
rollback_log_path = node['weefp1']['cache'] + "/silent_rollback.log"
  
  log "Creating the response file" 
  template response_path do
    source "weefp1_rollback.rsp.erb"
    owner  'root'
    group  'root'
    mode   '0600'
    action :touch
  end
  
  log "Silent rollback of Worklight FP1 if /opt/IBM/Worklight/ exists" 
  if File.directory? '/opt/IBM/Worklight/'
   bash "rollback_weefp1" do
    code <<-EOL
    /opt/IBM/WebSphere/Liberty/bin/server stop simpleServer
    /opt/IBM/InstallationManager/eclipse/tools/imcl input #{response_path} -log #{rollback_log_path} -acceptLicense
    /opt/IBM/WebSphere/Liberty/bin/server start simpleServer
    EOL
   end 
  end