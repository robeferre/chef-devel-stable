################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "cognos_tm1_102"
description "Cognos TM1 Server installation."
run_list(
	"recipe[cognos_tm1_10.2::install_102]"
  )
