################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "db297"
description "DB2 v9.7 installation"
run_list(
  "recipe[db2_ese_v10::server_install]"
  )
