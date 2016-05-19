################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "wee6fp1"
description "Worklight Enterprise Edition 6 install Fix Pack 1."
run_list(
  "recipe[weefp1::install]"
  )