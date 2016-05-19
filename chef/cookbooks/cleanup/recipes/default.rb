cache_dir = Chef::Config[:file_cache_path]

  log "Cleaning Up the /tmp/chef-solo dir"
  execute "Cleaning Up the Chef Cache dir" do
    user "root"
    cwd cache_dir
    command "rm -rf *"
    action :run
  end