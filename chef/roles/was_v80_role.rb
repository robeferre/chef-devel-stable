################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "was80"
description "IM Installation, Application server, profile creation."
run_list("recipe[was_nd_80::install_80]")
