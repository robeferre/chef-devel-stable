################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "websphere_MQ_7104"
description "Websphere MQ server."
run_list(
       "recipe[websphere_MQ_7104::install_client]"
  )
