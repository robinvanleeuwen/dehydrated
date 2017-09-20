#!/usr/local/bin/bash

echo "Last Run $(date)" > /var/log/update_ssl_certificates.log

source /usr/local/etc/dehydrated/config

cp $OPENSSL_CNF /tmp/openssl.org

for i in `cat $DOMAINS_TXT`; do 
   sed -e "/\[ req_distinguished_name \]/,/^\[/s/commonName                      = .*/commonName                      = $i/" $OPENSSL_CNF > /tmp/tmp_openssl.cnf
   mv /tmp/tmp_openssl.cnf $OPENSSL_CNF
   /opt/dehydrated/dehydrated -c -d $i

done

cp /tmp/openssl.org $OPENSSL_CNF

