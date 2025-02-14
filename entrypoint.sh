#!/usr/bin/env sh

set -e

echo "Installing bash"
apk add --no-cache bash

echo "Installing git & make"
apk add --no-cache git make

echo "Cloning git-secrets code from github"
git clone https://github.com/awslabs/git-secrets.git

echo "Installing git-secrets"
cd git-secrets && make install && cd $GITHUB_WORKSPACE

echo "Adding pattern to catch"
git secrets --add 'password\s*=\s*.+'

echo "PWD $(pwd)"
echo "ls $(ls -al)"

set +e

echo "Running git-secrets"
#git secrets --scan
git secrets --scan 2> secret_logs.txt
cat secret_logs.txt | grep -q "[ERROR]";
_secret_exists=$?

if [ ${_secret_exists} == 0 ]; then
    # Secrets exist. Echo error and exit with code 1
    echo -e '\033[1;31mSecrets exist in your commits. Please rectify the bad commits and re-commit.\033[0m'
    cat secret_logs.txt
    rm -rf secret_logs.txt
    exit 1
else
    # Secrets don't exist. Exit with code 0
    echo -e '\033[1;32mNo secrets exist in your commits.\033[0m'
    exit 0
fi 
