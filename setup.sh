#!/bin/bash

cd /autograder/source

echo "Installing dependencies"
apt update

echo "Setting up SSH"
mkdir -p /root/.ssh
mv deploy_key /root/.ssh/deploy_key
mv deploy_key.pub /root/.ssh/deploy_key.pub
mv ssh_config /root/.ssh/config

echo "======================Repository address========================="
cat repo
echo "====================End Repository address======================="
echo ""
echo "=========================Public Key=============================="
cat /root/.ssh/deploy_key.pub
echo "=======================End Public Key============================"

echo "Assert that the above key (deploy key) matches the one in the repository"

# To prevent prompt when cloning repo from github.com
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

git clone $(cat repo) /autograder/repo

bash /autograder/repo/setup.sh
