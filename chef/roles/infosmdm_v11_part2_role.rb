################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "infosmdm_v11"
description "IBM InfoSphere MDM v11 (Part2) Middleware Installation"
run_list(
  "recipe[infosmdm_v11::install]"
  )
