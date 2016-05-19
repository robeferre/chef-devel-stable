##########################################################################################################
# Licensed Materials - Property of IBM Copyright IBM Corporation 2012. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP
# Schedule Contract with IBM Corp.
##########################################################################################################

# Author:: Daniel Abrao (<dasc@br.ibm.com>)
# Cookbook:: IBM Network Handler
# Library:: network_helper

module IBMNetworkHelper
 module NetworkHelper
  
  def better_server
    results = {}
    
    node['ibm']['network']['install_servers'].each do |server|
      @icmp = Net::Ping::ICMP.new(server)
      failures = 0
      times =[]
      tests = 4

      # run the ping test 4x
       (1..tests).each do
        @icmp.ping         
         
         if (@icmp.duration.nil?)
           # send value 1 if any ping doesn't works
           times.push(1)
         else
          times.push(@icmp.duration)
         end
       end
      results[server] = times.min
     end
    
    # get the better value
    best_value = results.values.min
   
    # get and return the better server
    better_server = results.key(best_value)
    
    # temp code to force dst.lexington.ibm.com when in blue zone
    if (results['dst.lexington.ibm.com'] != 1)
      better_server = 'dst.lexington.ibm.com'
    end
    
    better_server
  end
  
 end
end

Chef::Recipe.send(:include, IBMNetworkHelper::NetworkHelper)