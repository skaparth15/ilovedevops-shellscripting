#!/bin/bash
userid=$(id -u)
scriptFileName=$(echo $0 | cut -d "." -f1)
timeStamp=$(date +%F+%H-%M-%S)
Logfile=/tmp/${scriptFileName}-${timeStamp}.log  
validateUser()
{
    if [ $userid -eq 0 ]
    then 
    echo "you are a root user ,proceed to install"
    else 
    echo "for installing a software you should have a root previliges"
    exit 1
    fi 
}


validateSoftwareStatus()
{
    if [ $? -eq 0]
    then
    echo "$1 Successfull"
    else
    echo "$1 Failed"
    exit 1
    fi
}

echo "starting to install the nginx server"
validateUser
dnf install nginx -y &>>$Logfile
validateSoftwareStatus "nginx software installation" 
echo "enabiling and starting the nginx server"
systemctl enable nginx
systemctl start nginx
echo "Removing the default content that web server is serving"

rm -rf /usr/share/nginx/html/* &>>$Logfile
validateSoftwareStatus "removing the existing content"

echo "Started downloading the frontend content"
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$Logfile
validateSoftwareStatus "download of frontend into temp"

cd /usr/share/nginx/html

echo "Extracting the frontend content..."

unzip /tmp/frontend.zip 

validateSoftwareStatus "replacing the downloaded content in the usr/share/nginx/html/"

echo "Creating  Nginx Reverse Proxy Configuration for enrouting the user request to main server"

cp /home/ec2-user/ilovedevops-shellscripting/expense.conf.txt /etc/nginx/default.d/expense.conf

validateSoftwareStatus "copying expense conf to /etc/nginx/default.d/"

echo "Restarting the nginx server"

systemctl restart nginx

echo "setup for the frontend is done ,please check for the status"








