# The new hosts file needs distributed amongst the nodes

fileItemString=$(cat /etc/hadoop/conf/slaves |tr "\n" " ")

fileItemArray=($fileItemString)

for hostname in "${fileItemArray[@]}"
do
    echo "Copying DNS files to $hostname"
    scp -o StrictHostKeyChecking=no  /etc/dnsmasq.d/0hosts root@$hostname:/etc/dnsmasq.d/0hosts
    scp -o StrictHostKeyChecking=no  /etc/banner_add_hosts root@$hostname:/etc/banner_add_hosts
    ssh -o StrictHostKeyChecking=no  root@$hostname "service dnsmasq restart"
done

exit
