 # Reset the file descriptors
  execute "Running fs.file-max=500000" do
    user "root"
    command "sysctl -w fs.file-max=500000"
    action :nothing
  end
  
  execute "Changing the maximum number of open files - soft" do
    user "root"
    command "echo '* soft nofile 10240' >> #{node['is']['limits_conf']}"
    not_if "grep '* soft nofile 99999' #{node['is']['limits_conf']}"
    action :run
  end
  
  execute "Changing the maximum number of open files - hard" do
    user "root"
    command "echo '* hard nofile 10240' >> #{node['is']['limits_conf']}"
    not_if "grep '* hard nofile 99999' #{node['is']['limits_conf']}"
    action :run
  end
  
  execute "Changing the maximum number of open files ..." do
    user "root"
    command "echo '* - nofile 99999' >> #{node['is']['limits_conf']}"
    not_if "grep '* - nofile 99999' #{node['is']['limits_conf']}"
    action :run
  end
  
  
  # Creates a startup process
  execute "Creating the UCD Startup script ..." do
    user "root"
    command "echo 'sh /opt/ibm/ucd/agent/bin/ibm-ucdagent start &' >> /etc/rc.d/rc.local"
    not_if "grep ibm-ucdagent /etc/rc.d/rc.local"
    action :run
  end
  
  # Reboot the server
  execute "Rebooting Server ..." do
    user "root"
    command "shutdown -r now"
    action :run
  end
  
  
  log "Process complete. Wait a few seconds to run the Step 2 - Deploy."
