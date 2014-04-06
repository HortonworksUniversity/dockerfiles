#!/bin/bash

# We need the incoming IP address of the datanode to properly have a reverse DNS lookup
# dnsmasq is configured to use a file named /etc/banner_add_hosts for reverse DNS

# Usage: <workernode_ip> <workernode_name>

# Check if the host already is in slaves
fileItemString=$(cat /etc/hadoop/conf/slaves |tr "\n" " ")
fileItemArray=($fileItemString)
for hostname in "${fileItemArray[@]}"
do
	if [[ "$hostname" == "$2" ]]; then
        	echo "WARN: $2 already exists in slaves. It's IP address was not updated in the hosts file."
        	exit
	fi
done



# Add the server name to the slaves file
echo $2 >> /etc/hadoop/conf/slaves    

# The banner_add_hosts entries provide reverse DNS
echo $1 $2 >> /etc/banner_add_hosts 

# The dnsmasq hosts file has a specific format
echo 'address="/'$2'/'$1'"'
echo 'address="/'$2'/'$1'"' >> /etc/dnsmasq.d/0hosts 


service dnsmasq restart

exit
