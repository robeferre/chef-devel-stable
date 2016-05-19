################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

name "wcm_85"
description "Web content Manager 8.5 install"
run_list(
  	"recipe[ContentManagement_85::install_85]"
  )
