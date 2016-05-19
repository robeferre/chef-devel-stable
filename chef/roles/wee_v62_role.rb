################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "wee_v62"
description "IBM Worklight Enterprise Edition v6.2."
run_list(
  "recipe[im::install]",
  "recipe[wasl_v855]",
  "recipe[wee_v62::install]"
  )