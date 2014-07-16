#!/bin/bash

for script in `ls -1 /root/start-scripts/`
do
    /root/start-scripts/$script 
done
