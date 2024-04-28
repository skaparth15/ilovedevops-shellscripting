#!/bin/bash
find_sum(){
    sum=0
    len=$#
    enteredarguments=$@

    for i in $enteredarguments
    do
      sum=$((sum + i))
    done 
      Avg_Of_Num=$((sum/len))
      echo " $Avg_Of_Num"
      return $Avg_Of_Num

}

EndResult=$(find_sum 20 30 40 50)
echo "sum of the values are $EndResult"