#!/bin/bash

#Add Nagios email to Ambari blueprint
if [[ ! -z $NAGIOS_EMAIL ]]; 
then
  sed -i "s/NAGIOS_EMAIL/$NAGIOS_EMAIL/g" /root/blueprints/*.blueprint 
fi

