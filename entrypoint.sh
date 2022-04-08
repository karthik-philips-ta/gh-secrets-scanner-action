#!/usr/bin/env sh

set -e

echo "Installing bash"
apk add --no-cache bash

echo "Installing git & make"
apk add --no-cache git make

echo "Cloning git-secrets code from github"
git clone https://github.com/awslabs/git-secrets.git

echo "Installing git-secrets"
cd git-secrets && make install && cd ..

echo "Adding pattern to catch"
git secrets --add 'password\s*=\s*.+'

echo "PWD $(pwd)"
echo "ls $(ls -al)"

echo "Running git-secrets"
git secrets --scan
