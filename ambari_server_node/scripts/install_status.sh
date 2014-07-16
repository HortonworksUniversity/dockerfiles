#!/bin/bash

java -jar /root/scripts/ambari-shell.jar --ambari-server=namenode << END
tasks
quit
END
