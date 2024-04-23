#!/bin/bash
Variable1=3
Variable2=4
Variable3=$(($Variable1+$Variable2)) #addition of two numbers


echo "addition of ${Variable1} and ${Variable2} is ${Variable3}"

Name=$1 #passing a input as an arguments from a user

echo "name of the person is $Name"

echo "Enter the candidate's name:"

read -s USERNAME  # reads the input from the user and stores into variable (USERNAME)
# -s will restrict the visibility of the input on terminal
echo "name of candidate is $USERNAME " 
echo "num of arguments passed :$#" # $# will store the total no of arguements passed at the begining of the script execution








