name             "bpm_ps_8000"
maintainer       "IBM"
maintainer_email "flageuls@fr.ibm.com"
license          "Apache 2.0"
description      "Business Process Manager - Process Server."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"
depends          "chef_handler"
depends		 "windows"
depends		 "im"
depends		 "ibm_network_handler"