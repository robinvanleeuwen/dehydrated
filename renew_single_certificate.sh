#!/usr/local/bin/bash
echo "Script ran on $(date)" >> /var/log/replace_single_certificate.log

source /usr/local/etc/dehydrated/config

if [ "$1" == "" ]; then
    echo "Usage: $0 <domain>"
    exit
fi

echo " - Backup up $OPENSSL_CNF"
cp $OPENSSL_CNF /tmp/openssl.org

echo " - Replacing domain in new OpenSSL config"
#sed -e "/\[ req_distinguished_name \]/,/^\[/s/commonName[[:blank:]]+= .*/commonName = $1/" $OPENSSL_CNF > /tmp/tmp_openssl.cnf
sed -e "/\[ req_distinguished_name \]/,/^\[/s/commonName[[:blank:]]*=[[:blank:]].*/commonName = $1/" $OPENSSL_CNF > /tmp/tmp_openssl.cnf


echo " - Updating $OPENSSL_CNF"
cp /tmp/tmp_openssl.cnf $OPENSSL_CNF
cat $OPENSSL_CNF
/opt/dehydrated/dehydrated -x -c -d $1

echo " - Restoring backupped $OPENSSL_CNF"
cp /tmp/openssl.org $OPENSSL_CNF



