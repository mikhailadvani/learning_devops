#!/bin/bash
if [ -z "$1" ]
then
    echo "File name is mandatory"
    exit 1
fi
echo "Creating pem file with name" $1
openssl genrsa -out $1.pem 2048
echo "Created file with name" $1".pem"
chmod 400 $1".pem"

echo "Sorry you need to mention the .pem file again:"

ssh-keygen -y > to_be_appended_to_known_hosts_on_remote_machine.txt