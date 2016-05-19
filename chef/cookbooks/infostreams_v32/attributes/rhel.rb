case node['platform_family']
when 'rhel'
  default['infostreams']['pkg_file']             = "Streams-3.2.1.0-x86_64-el6.tar.gz"
  default['infostreams']['pkg_url']              = "/install/CHEF_FILES/DSTSA/INFOSTREAMS32/RHEL/Streams-3.2.1.0-x86_64-el6.tar.gz"
  default['infostreams']['version']              = '3.2.1'
  default['infostreams']['cache']                = Chef::Config[:file_cache_path] + "/streams_install"
  default['infostreams']['installer_dir']        = "#{node['infostreams']['cache']}/StreamsInstallFiles"
  default['infostreams']['response_file']        = "#{node['infostreams']['cache']}/infostreams.properties"
  default['infostreams']['license_dir']          = "/home/streamsadmin/.streams/.product_cert"
  default['infostreams']['user_home']            = "/home/streamsadmin/"
  default['infostreams']['bin_dir']              = "/home/streamsadmin/InfoSphereStreams/bin"
  default['infostreams']['base_install']         = "/home/streamsadmin/InfoSphereStreams"
  default['infostreams']['custom_repo']          = "#{node['infostreams']['cache']}/repo"
end