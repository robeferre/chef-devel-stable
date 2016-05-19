RESPFILE_BPM_PATH = "#{node['bpm8012']['config']['cache']}/#{node['bpm8012']['respfile']['bpm']}"

RESPFILE_WAS_PATH = "#{node['bpm8012']['config']['cache']}/#{node['bpm8012']['wasrsp']['file']}"

#############################################
#
# Check if the tools is not already install
#
#############################################

class Chef::Recipe
  include Helper_bpm_8012
end


if package_already_installed == false

   include_recipe "ibm_network_handler"

   ######################################################
   #
   # create Cache_path and unzip the product package file
   #
   ######################################################
  log "---DST - Create the directory #{node['bpm8012']['config']['mount']}----" 
 
	directory node['bpm8012']['config']['mount'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   
  
 log "--DST - Create the directory #{node['bpm8012']['config']['cache']}--" 

	directory node['bpm8012']['config']['cache'] do
	 rights :full_control,'Administrator'
	 recursive true
	 action :create
	end   

  

   ##################################
   #
   # Create response file
   #
   ##################################

   log " ----DST - Create a reponse file -----"

   template "#{RESPFILE_BPM_PATH}" do
     source node['bpm8012']['resperb']['bpm']	
     action :touch
     variables({
	      :repository_location => "\'C:\\DST\\bpm8012_base_install\\unzip\'",
	      :installLocation     => "\'E:\\BPM\\V8.0\'",
	      :eclipseLocation     => "\'E:\\BPM\\V8.0\'",
	      :os                  => "\'win32\'",
	      :arch                => "\'x86\'",
	      :ws                  => "\'win32\'",
	      :eclipseCache        => "\'C:\\Program Files (x86)\\IBM\\IMShare\'"
    })
    end

log " ----DST - Create a reponse file WAS for BPM-----"

	template "#{RESPFILE_WAS_PATH}" do
    		source node['bpm8012']['wasrsp']['erb']
    		action :touch
    		variables({
      		:repository_location => "\'C:\\DST\\was_nd_8007_base_install\\unzip\'",
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

