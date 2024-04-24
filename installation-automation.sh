#!/bin/bash
echo "which software you want to execute "
read SOFTWARE
USER=$(id -u)
if [ ${USER} -eq 0 ]
then
echo "you are a super user"
echo "starting the installation ......"
else 
echo "For installing any software you must have root access"
exit 1;
fi

dnf install ${SOFTWARE}
EXITSTATUS=$?
echo "$EXITSTATUS"
if [$EXITSTATUS -eq 0]
then 
echo "${SOFTWARE} has downloaded sucessfully"
else
echo "Downloading ${SOFTWARE} has failed ,please   check for the logs"
fi