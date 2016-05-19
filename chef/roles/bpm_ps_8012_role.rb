################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "bpm_ps_8012"
description "IM Installation, Application server, profile creation."
run_list(
    "recipe[bpm_ps_8012::install_ps_server]"
  )
