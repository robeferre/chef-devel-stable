################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "infostreams_v32"
description "IBM InfoSphere Streams v3.2.1"
run_list(
  "recipe[infostreams_v32::install]"
  )
