#!/bin/bash
echo "started installing mys1l-server"
userid=$(id -u)
scriptname= echo $0 | cut -d "." -f1
echo $scriptname
Logfile= /tmp/$scriptname.log

userVerification(){
    if [ ${userid} -eq 0 ]
    then 
        echo "you are a root user, have access to install softwares"
    else 
         echo "For Installing you should have root previliges"
         exit 1
    fi

}
    $userVerification
    dnf install mysql-server -y >> $Logfile

 