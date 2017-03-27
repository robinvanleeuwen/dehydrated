#!/usr/local/bin/bash


source /usr/local/etc/dehydrated/config

for i in `cat $DOMAINS_TXT`;do 

   /opt/dehydrated/dehydrated -c -d $i

done

