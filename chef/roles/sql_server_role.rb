################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
################################################################################
name "sql_server"
description "This cookbook is intended to deploy Sql Server 2008 R2 Development Edition"
run_list("recipe[sql_server::server]")
