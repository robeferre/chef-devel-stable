################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "ihs_8551"
description "Http Server 8.5.5.1 install."
run_list(
  "recipe[im::install]",
  "recipe[ihs_8550::install_8550]",
  "recipe[ihs_8551::install_8551]"
  )