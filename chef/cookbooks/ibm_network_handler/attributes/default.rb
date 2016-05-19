##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################


default['ibm']['network']['install_servers'] = ['dst.lexington.ibm.com',
                                                'dst.bcsdc.lexington.ibm.com',
                                                'dst.boulder.ibm.com',
                                                'byz-nim.bcsdc.lexington.ibm.com',
                                                'dst-nim.austin.ibm.com',
                                                'dst.raleigh.ibm.com',
                                                'dst.sby.ibm.com',
                                                'dst.br.ibm.com',
                                                'dst.toronto.ca.ibm.com',
                                                'dst.dk.ibm.com',
                                                'mopbz171141.pssc.mop.fr.ibm.com',
                                                '10.106.89.15',
                                                '10.106.148.76',
                                                '12.169.40.86']

case node['platform_family']
when 'windows'
        default['ibm']['network']['gems_repository'] = "C:\\devops\\common\\chef\\cookbooks\\gems\\"
when 'rhel'
        default['ibm']['network']['gems_repository'] = "/devops/common/chef/cookbooks/gems/"
when 'aix'
        default['ibm']['network']['gems_repository'] = "/devops/common/chef/cookbooks/gems/"
end