################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "biginsghts_20"
description "IBM InfoSphere BigInsights v2.0"
run_list(
    "recipe[biginsights_v20::install]"
  )