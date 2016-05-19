name             'wlp'
maintainer       'IBM'
maintainer_email ''
license          'Apache 2.0'
description      'Installs WebSphere Application Server Liberty Profile'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'

supports         "debian"
supports         "ubuntu"
supports         "centos"
supports         "redhat"

depends          "java", ">= 1.16.4"
depends          "ibm_network_handler"