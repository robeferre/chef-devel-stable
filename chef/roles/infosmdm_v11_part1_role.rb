################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "infosmdm_v11"
description "IBM InfoSphere MDM v11 (Part1) Pre Required Installations"
run_list(
  "recipe[infosmdm_v11::rhell_install_part1]"
  )
