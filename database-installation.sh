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

    if [ ${EXITSTATUS} -eq 0 ]
    then 
        echo "$1 Successful"
    else
        echo "$1 Failed"
        exit 1
    fi
 }  

   systemServiceOperation(){
    operationName=$1
    softwareName=$2
    systemctl ${operationName} ${softwareName}
   }  
    userVerification
    dnf install mysql-server -y &>>$Logfile
    softwareInstallationValidation "mysql-installation"
    echo "enabiling the mysqlserver"
   # systemctl enable mysqld &>>$Logfile
    systemServiceOperation "enable" "mysqld"
    softwareInstallationValidation "enabiling mysqld"

    echo "starting the mysql aerver"
    #systemctl start mysqld &>>$Logfile
    systemServiceOperation "stop" "mysqld"
    softwareInstallationValidation "stoping-mysqld-service"


