#!/bin/bash
echo "which software you want to execute "
read SOFTWARE
USER=$(id -u)
if [ $USER -ne 0 ]
then
dnf install $SOFTWARE -y
echo "completed the installation"
else 
echo "For installing any software you must have root access"
fi