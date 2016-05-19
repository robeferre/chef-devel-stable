################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "ihs_8004"
description "Http Server 8.0.0.4 install"
run_list(
  "recipe[im::install]",
  "recipe[ihs_8000::install_8000]",
  "recipe[ihs_8004::install_8004]"
  )