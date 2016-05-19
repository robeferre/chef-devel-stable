#################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2014. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
#################################################################

# Invoking the Network Handler to figure out the best server available
include_recipe "ibm_network_handler"

# Install Cognos BI & Samples
include_recipe 'cognos_bi_10.2.1::cognos_bi_smps_rhel_1021'

# Setup Netezza ODBC connection
include_recipe 'cognos_bi_10.2.1::cognos_bi_netezza_setup'

# Load GS_DB to DB2
include_recipe 'cognos_bi_10.2.1::cognos_bi_smps_db2_setup'

