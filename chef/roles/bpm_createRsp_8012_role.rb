################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "bpm_createRsp_8012"
description "Create Response file for install in E partition."
run_list(
    "recipe[bpm_ps_8012::Create_rspFile_windows_PODC]"
  )
