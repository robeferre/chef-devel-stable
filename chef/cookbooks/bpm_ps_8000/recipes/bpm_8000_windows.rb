###########################################################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#######################################################################
RESPONSE_FILE_PATH = "#{node['bpm8000']['config']['cache']}/#{node['bpm8000']['respfile']['bpm']}"

#############################################
#
# Check if the tools is not already install
#
#############################################


class Chef::Recipe
  include Helper_BPM_8000
end

if package_already_installed == false

   ######################################################
   #
   # create Cache_path and unzip the product package file
   #
   ######################################################
	
   include_recipe 'bpm_ps_8000::packageFile_PS_windows'
  

   ##################################
   #
   # Create response file
   #
   ##################################
if (!(File.exists?(RESPONSE_FILE_PATH)))
   log " ----DST - Create a reponse file -----"

   template "#{RESPONSE_FILE_PATH}" do
     source node['bpm8000']['resperb']['bpm']	
     action :touch
     variables({
	      :repository_location => "\'C:\\DST\\bpm8000_base_install\\unzip\\repository\\repos_64bit\'",
	      :installLocation     => "\'C:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'C:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
    end
end

    log " -------DST - Installation of BPM -------"

    execute "Install BPM 8000" do
      cwd node['im']['base']['path']
      command "imcl.exe input #{RESPONSE_FILE_PATH} -log C:/tmp/install_bpm8000_log.xml -acceptLicense"
      action :run
    end

else

  log "IBM Business Process Manager - Process Server is already installed!" do
  level :info
  end

end

