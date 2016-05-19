################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "cognos_bi_tm1_1021"
description "Cognos BI TM1 installation."
run_list(
     "recipe[cognos_bi_10.2.1::install_1021]"
  )
