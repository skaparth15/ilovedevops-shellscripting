#!/bin/bash
echo "started installing mys1l-server"
userid=$(id -u)
Timestamp=$(date +%F-%H-%M-%s)
scriptname=$(echo $0 | cut -d "." -f1)
echo $scriptname
Logfile=/tmp/$scriptname-$Timestamp.log

userVerification(){
    if [ ${userid} -eq 0 ]
    then 
        echo "you are a root user, have access to install softwares"
    else 
         echo "For Installing you should have root previliges"
         exit 1
    fi

}

softwareInstallationValidation(){
    EXITSTATUS=$?

    if [$EXITSTATUS -eq 0]
    then 
        echo "Installation Sucessful"
    else
        echo "Installation Failed"
        exit 1
    fi
 }    
    userVerification
    dnf install mysql-server -y >>$Logfile
    softwareInstallationValidation
 