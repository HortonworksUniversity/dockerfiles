These Dockerfile images can be used for installing an HDP 2 cluster. There are two Dockerfile definitions:

1) hdp_node_base/Dockerfile: installs HDP 2.0 and configres SSH
2) hdp_node/Dockerfile: installs any extraneous software and configures DNS, etc

The following instructions assume you have Docker installed. I used VMWare Fusion on my Mac to create an Ubuntu image, then installed Docker onto Ubunutu. Then clone the repo onto your Ubuntu machine and follow these instructions below.

To use these images in coordination with the pre-written scripts in /dockerfiles/start_scripts, you need to build and name the images
as follows:

cd hdp_node_base
docker build -t hwx/hdp_node_base .
cd ../hdp_node
docker build -t hwx/hdp_node .


Once you have built the two images above, you can start a cluster (NameNode, Secondary NameNode, ResourceManager, Hive/Oozie/WebHCat server, and x number of Worker Nodes) using the start_cluster.sh script. For example, if you want 8 worker nodes:

start_scripts/start_cluster.sh hwx/hdp_node 8



TIP: There is a hosts file that can be used to put on your host machine which assigns convenient hostnames to the cluster machines.



You can also start each component separately using the various scripts in the start_scripts folder. For example, to start a new NameNode:

./start_scritps/namenode_run.sh hwx/hdp_node


Once you have the IP address of the NameNode, then you can startup the other nodes. For example, if the IP address of 
the NameNode is 172.17.0.2, then you start the ResourceManager with:

./start_scripts/resourcemanager_run.sh 172.17.0.2 hwx/hdp_node


WorkerNodes need a name (which ends up being their hostname). For example:

./start_scripts/workernode_run.sh mynode1 172.17.0.2 hwx/hdp_node

