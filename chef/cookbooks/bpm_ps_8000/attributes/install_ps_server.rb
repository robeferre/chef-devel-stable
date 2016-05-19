# Config directory
default['bpm8000']['config']['mount']	=  Chef::Config[:file_cache_path] + "/bpm8000_base_install"


case node['platform_family']

when 'rhel'
 
when 'aix'
   
when 'windows'

    # Installation Manager
   default['im']['base']['path']		= 'C:/Program Files/IBM/Installation Manager/eclipse/tools'

   default['bpm8000']['base']['path']		= 'C:/bpm/V8.0'
   default['bpm8000']['config']['cache']	= "C:/DST/bpm8000_base_install/unzip"
  
   default['bpm8000']['zip']['file1']		= "BPM_Adv_V800_Windows_1_of_3.zip"
   default['bpm8000']['zip']['file2']		= "BPM_Adv_V800_Windows_2_of_3.zip"
   default['bpm8000']['zip']['file3']		= "BPM_Adv_V800_Windows_3_of_3.zip"
   default['bpm8000']['zip']['file4']		= "CZZ8EML.zip"
   default['bpm8000']['zip']['file5']		= "DB2_ESE_97_Win_x86-64.exe"
   default['bpm8000']['zip']['file6']		= "DB2_ESE_Restricted_QS_Activation_97.zip"
   default['bpm8000']['zip']['file7']		= "tds63-win-x86-64-base.zip"
   
   default['bpm8000']['zip']['location1']	= "/install/CHEF_FILES/BPM/V80/BPM_Adv_V800_Windows_1_of_3.zip"
   default['bpm8000']['zip']['location2']	= "/install/CHEF_FILES/BPM/V80/BPM_Adv_V800_Windows_2_of_3.zip"
   default['bpm8000']['zip']['location3']	= "/install/CHEF_FILES/BPM/V80/BPM_Adv_V800_Windows_3_of_3.zip"
   default['bpm8000']['zip']['location4']	= "/install/CHEF_FILES/BPM/V80/CZZ8EML.zip"
   default['bpm8000']['zip']['location5']	= "/install/CHEF_FILES/BPM/V80/DB2_ESE_97_Win_x86-64.exe"
   default['bpm8000']['zip']['location6']	= "/install/CHEF_FILES/BPM/V80/DB2_ESE_Restricted_QS_Activation_97.zip"
   default['bpm8000']['zip']['location7']	= "/install/CHEF_FILES/BPM/V80/tds63-win-x86-64-base.zip"

   default['bpm8000']['resperb']['bpm']		= "bpm_8000_resp.xml.erb"
   default['bpm8000']['respfile']['bpm']	= "bpm_8000_resp.xml"
   default['bpm8000']['resperb']['was']		= "was_nd_8003_resp.xml.erb"
   default['bpm8000']['respfile']['was']	= "was_nd_8003_resp.xml"
   default['bpm8000']['resperb']['dbexpress']	= "db_express_9704_resp.xml.erb"
   default['bpm8000']['respfile']['dbexpress']	= "db_express_9704_resp.xml"
end