name             "cognos_tm1_1021"
maintainer       "IBM"
maintainer_email "flageuls@fr.ibm.com"
license          "Apache 2.0"
description      "IBM cognos TM1."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0"
depends          "chef_handler"
depends		 "ibm_network_handler"
depends		 "im_173"
depends		 "ihs_8550"
depends		 "ihs_8551"
depends		 "db2_ese_v10"