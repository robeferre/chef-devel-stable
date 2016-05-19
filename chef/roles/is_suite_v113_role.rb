################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "infosphere_v113"
description "IBM InfoSphere Information Server v11.3"
run_list(
  "recipe[infosphere_v113::install]"
  )
