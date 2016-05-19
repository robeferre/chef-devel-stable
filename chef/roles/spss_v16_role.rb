################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "spss_v16"
description "IBM SPSS Modeler Server v16.0 installation"
run_list(
  "recipe[spss_v16::install]"
  )
