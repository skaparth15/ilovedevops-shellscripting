#!/bin/bash
user=$(id -u)
scriptFileName=$(echo $0 | cut -d "." -f1)
timeStamp=$(date +%F-%H-%M-%S)
Logfile=/tmp/${scriptFileName}-${timeStamp}.log  
ApplicationUser="expense"

softwareValidation(){
    if [$? -eq 0]
    then 
        echo "$1 Successful"
    else 
       echo "$1 Failed ,please check for the logs" 
       exit 1
    fi
}


if [ $user -eq 0 ]
    then
        echo "you're root user,have access to execute this script"
        exit 1
    else
        echo "For running this script you should have root previliges"
fi
echo "Started  configuration for backend server ...."
echo "enter the nodejs version you want to disable"
read nodejsVersion
dnf module disable nodejs:$nodejsVersion -y &>>$Logfile
softwareValidation  "disabled nodejs"
echo "enter the nodejs version to be enabled, as per developers requirement"
read nodejsVersionToEnable
dnf module disable nodejs:$nodejsVersionToEnable -y &>>$Logfile
softwareValidation  "enabled nodejs"
dnf install nodejs -y &>>$Logfile
softwareValidation  "installing nodejs"
echo  "Adding User ${ApplicationUser} is a function , daemon user to run the application"

id ${ApplicationUser}
if [$? -ne 0]
then 
  useradd ${ApplicationUser} 
  softwareValidation "user added "
else
  echo "${ApplicationUser} already exists,so no need to add skipping....." 
fi 

mkdir -p /app
echo "downloading the required code for the application"
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$Logfile
softwareValidation  "downloading nodejs code"
cd /app
rm -rf /app/* &>>$Logfile
unzip /tmp/backend.zip &>>$Logfile
npm install &>>$Logfile
softwareValidation "downloading the project dependencies"
mv /home/ec2-user/ilovedevops-shellscripting/backend.service /etc/systemd/system/backend.service
softwareValidation  "configuration to backend server"
systemctl daemon-reload &>>$LOGFILE

systemctl start backend &>>$LOGFILE

systemctl enable backend &>>$LOGFILE

echo "installing mysql client to load schema from mysql server"
dnf install mysql -y &>>$Logfile
softwareValidation "installing mysql-client "
echo "enter the mysql-server pass:"
read mysqlSeverPass
mysql -h 172.31.23.173 -uroot -p${mysqlSeverPass} < /app/schema/backend.sql &>>$Logfile
softwareValidation "schema got loaded sucessfully"
systemctl restart backend















