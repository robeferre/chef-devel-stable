# Config directory
default['bpm8012']['config']['mount']	=  Chef::Config[:file_cache_path] + "/bpm8012_base_install"


case node['platform_family']

when 'rhel'
 
   
when 'aix'
   
   
when 'windows'

  # Installation Manager
   default['im']['base']['path']		= 'C:/Program Files/IBM/Installation Manager/eclipse/tools'

   default['im']['base']['path']		= 'C:/Program Files/IBM/Installation Manager/eclipse/tools'
   default['bpm8012']['wasrsp']['erb'] = "was_nd_8007_resp.xml.erb"
   default['bpm8012']['wasrsp']['file']	= "was_nd_8007_resp.xml"
   default['bpm8012']['base']['path']		= 'C:/bpm/V8.0'
   default['bpm8012']['config']['cache']	= "C:/DST/bpm8012_base_install/unzip"
   default['bpm8012']['zip']['file1']		= "bpmAdv.8012.repository.zip"
   default['bpm8012']['zip']['location1']	= "/install/CHEF_FILES/BPM/V80/FixPack/bpmAdv.8012.repository.zip"
   default['bpm8012']['resperb']['bpm']		= "bpm_8012_resp.xml.erb"
   default['bpm8012']['respfile']['bpm']	= "bpm_8012_resp.xml"
end