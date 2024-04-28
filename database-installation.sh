#!/bin/bash
echo "started installing mys1l-server"
userid=$(id -u)
if [ ${userid} -eq 0 ]
then 
    echo "you are a root user, have access to install softwares"
    dnf install mysql-server -y
    echo "sucessfully installed mysql-server"
else 
     
     echo "For Installing you should have root previliges"

fi

 