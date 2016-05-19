RESPFILE_WAS_PATH = "#{node['bpm8000']['config']['cache']}/#{node['bpm8000']['respfile']['was']}"
RESPFILE_DBEXP_PATH = "#{node['bpm8000']['config']['cache']}/#{node['bpm8000']['respfile']['dbexpress']}"
RESPFILE_BPM_PATH = "#{node['bpm8000']['config']['cache']}/#{node['bpm8000']['respfile']['bpm']}"


#############################################
#
# Check if the tools is not already install
#
#############################################

class Chef::Recipe
  include Helper_BPM_8000
end


if package_already_installed == false

   include_recipe "ibm_network_handler"

if (!(File.directory?(node['bpm8000']['config']['cache'])))

	log "---DST - Create the directory #{node['bpm8000']['config']['mount']}----" 
 
	directory node['bpm8000']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
	log "----DST - Create the directory #{node['bpm8000']['config']['cache']}----" 

	directory node['bpm8000']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
end

   ##################################
   #
   # Create response file
   #
   ##################################

   log " ----DST - Create a was reponse file -----"

   template "#{RESPFILE_WAS_PATH}" do
     source node['bpm8000']['resperb']['was']	
   	  action :touch
     	  variables({
	      :repository_location => "\'C:\\DST\\bpm8000_base_install\\unzip\\repository\\repos_64bit\'",
	      :installLocation     => "\'E:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'E:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    		})
   end

   log " ----DST - Create a bpm reponse file -----"

   template "#{RESPFILE_BPM_PATH}" do
     source node['bpm8000']['resperb']['bpm']	
     action :touch
     variables({
	      :repository_location => "\'C:\\DST\\bpm8000_base_install\\unzip\\repository\\repos_64bit\'",
	      :installLocation     => "\'E:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'E:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
    end

   log " ----DST - Create a DB2 Express reponse file -----"

   template "#{RESPFILE_DBEXP_PATH}" do
     source node['bpm8000']['resperb']['dbexpress']	
     action :touch
     variables({
	      :repository_location => "\'C:\\DST\\bpm8000_base_install\\unzip\\repository\\repos_64bit\'",
	      :installLocation     => "\'E:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'E:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
end

else

  log "Websphere Application Server ND is already installed!" do
  level :info
  end
end

