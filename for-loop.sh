#!/bin/bash
enteredelements=$@
totalnoofelements=$#
echo "enter a name :"
read enteredname
for name in $enteredelements
do
if [ $name = $enteredname ]
then 
 echo "$name is in list"
else 
 echo "$name is not in the list"
 fi
done


