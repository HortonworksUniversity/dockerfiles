#!/bin/bash

ambari-server start

while [ `curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://${AMBARI_SERVER}:8080` != 200 ]; do
  sleep 2
done

ambari-agent start
