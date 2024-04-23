#!/bin/bash
echo "all entered parameters :$@" # $@ stores all the enetered arguments 

echo "num of arguments passed :$#" # $# will store the total no of arguements passed at the begining of the script execution

echo "Current working directory: $PWD" # present working directory
echo "Current home directory: $HOME" # Home directory of the current user
echo "user name :${whoami}"
echo "hostname: $HOSTNAME"
echo "process id of the shell script:$$"
echo "exit status of the previous command:$?"
sleep 30


