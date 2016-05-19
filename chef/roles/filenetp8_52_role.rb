################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

name "filenetp8_52"
description "IBM FileNet P8 5.2 install"
run_list(
  	"recipe[FileNet_P8_52::install_52]"
  )
