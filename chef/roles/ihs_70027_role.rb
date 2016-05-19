################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

name "ihs_70027"
description "Http Server 7.0.0.27 install"
run_list(
  	"recipe[ihs_70::install_ihs_70]",
	"recipe[ihs_70::install_plg_70]",
	"recipe[ihs_70027::install_ihs_70027]",
	"recipe[ihs_70027::install_plg_70027]",
	"recipe[ihs_70027::start_ihs_70027]"

  )