Description
===========
* The ibm_network_handler cookbook is intended to solve network issues at IBM network infrastructure.

License
===========
* Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
* U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
* Schedule Contract with IBM Corp.

Attributes
===========
* ``node['ibm']['network']['gems']``            => This attribute contain all gems necessary to the cookbook execution.
* ``node['ibm']['network']['install_servers']`` => This is an array of INSTALL_SERVERS, if a server has added, we need to uptade this attribute file mannually.

* LIST OF THE AVAILABLE INSTALL_SERVERS:
  'dst.lexington.ibm.com', 
  'dst.bcsdc.lexington.ibm.com',
  'dst.boulder.ibm.com',
  'byz-nim.bcsdc.lexington.ibm.com',
  'dst-nim.austin.ibm.com',
  'dst.raleigh.ibm.com',
  'dst.sby.ibm.com',
  'dst.br.ibm.com',
  'dst.toronto.ca.ibm.com',
  'dst.dk.ibm.com'
  '10.106.89.15'

Usage
===========
* Add ``include_recipe[ibm_network_handler]`` somewhere on your run_list, or default recipe.
* Add ``depends "ibm_network_handler"`` on your metadata.rb file.

* This procedure will make the variable ``$BEST_SERVER`` available and can be importerted
* to your remote_file call or attribute. Eg:

* You should have to set your attributes files to use the URL like that:
* ``default['cookbook']['url'] = "/install/CHEF_FILES/SOFTARE/package_installer.tar.gz"``
* The URL should contain just the existing path after the name of the server. It is needed once the server's name will be
* obtained during the recipe execution, to attend to specification to select the better server  dynamically.

* In your recipe you should to build the source url to be used in the remote_file instruction like that:
* PACKAGE_FILE = "http://#{BEST_SERVER}#{node['cookbook']['url']}"

* In additional to that, you can be using this call directly in the remote_file source attribute like that:
*  remote_file package_file do
*    source "http://#{BEST_SERVER}#{node['cookbook']['url']}"
*    not_if { ::File.exists?(package_file) }
*  end

* After configure those steps your cookbook will be ready to use the "ibm_network_handler" cookbook, 
* the procedure will choice the best server to download your packages independently of the network that you reside.


Tests
===========
* At this moment this cookbook was tested on Blue Zone and SoftLayer.
* NOTE: Currently to the SoftLayer we are considering just the 10.106.89.15 server.


TODO
===========
* Test this cookbook at Softlayer servers.
* Rank the servers using the response time.
* Check the INSTALL_SERVERS consistency, all have to be syncronized.
* LOGS

Authors & Contributors
======================
* Daniel Abraao Silva Costa (dasc@br.ibm.com)
* Roberto Ferrira Junior (rfjunior@br.ibm.com)