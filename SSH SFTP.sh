#!/bin/bash


cat > ~/(NAME)-server-key.pem << EOL
-----BEGIN RSA PRIVATE KEY-----
(INSERT KEY HERE)
-----END RSA PRIVATE KEY-----
EOL

chmod 400 ~/(NAME)-server-key.pem

ssh-add ~/(NAME)-server-key.pem 

echo "alias (NAME)-server='ssh -i "~/(NAME)-server-key.pem" ubuntu@(SERVER-IP)'" >> ~/.bash_aliases && source ~/.bash_aliases

echo "To connect to (NAME)-server, type (NAME)-server..."

echo "alias (NAME)-files='nautilus ubuntu@(SERVER-IP)'" >> ~/.bash_aliases && source ~/.bash_aliases

echo "To open the file browser to (NAME)-server, type (NAME)-files..."
