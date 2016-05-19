################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "mysql_server5615"
description "MySQL Server 5.6.15 - Including connectors"
run_list(
     "recipe[mysql::server_install]"
  )