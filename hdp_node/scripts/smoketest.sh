hadoop fs -mkdir test
hadoop fs -put /root/scripts/startup.sh test
sudo -u hdfs /usr/bin/hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples-2.2.0.2.0.6.0-101.jar wordcount /user/root/test /user/root/output
