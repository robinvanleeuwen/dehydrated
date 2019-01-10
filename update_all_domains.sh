#!/usr/local/bin/bash

# Moved to overlying script that runs both update certs and renew in pfsense
#echo "Last Run $(date)" >> /var/log/update_ssl_certificates.log
echo "Starting script."
echo "Sourcing config file"
source /usr/local/etc/dehydrated/config
echo "Copying $OPENSSL_CNF"
cp $OPENSSL_CNF /tmp/openssl.org

echo "Running for loop"
for i in `cat $DOMAINS_TXT`; do 
   echo -n ". $i"
   sed -e "/\[ req_distinguished_name \]/,/^\[/s/commonName[[:blank:]]*=[[:blank:]].*/commonName = $i/" $OPENSSL_CNF > /tmp/tmp_openssl.cnf
   mv /tmp/tmp_openssl.cnf $OPENSSL_CNF
   echo -n "x"
   /opt/dehydrated/dehydrated -c -d $i >> /var/log/update_ssl_certificates.log
done
echo "Done fore loop"
echo "Copying original '$OPENSSL_CNF' back"
cp /tmp/openssl.org $OPENSSL_CNF
echo "Done script"

