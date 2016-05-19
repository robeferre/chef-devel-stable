################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "Oracle12g"
description "Oracle 12g"
run_list(
     "recipe[oracle_12g::server_install]"
  )