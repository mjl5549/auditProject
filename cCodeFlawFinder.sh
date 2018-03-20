#!/bin/bash
#Script to run flawfinder on large numbers of C/C++ programs source code for static analysis.

#first arg ($1) should be the full path to dir with the programs to be audited 
#second arg should be where you want the results.

#make a folder for results of flawfinder
mkdir "$2/results/"
resDir="$2/results/"

#use the dir that was entered as input 
pushd $1 > /dev/null

#get the list of programs to be ran through flawfinder
proDir=(`find . -maxdepth 1 -type d | cut -c3-`)
numPro=${#proDir[@]}

#perform static analysis on the programs
for ((i=0; i<${numPro}; i++))
do

#change into the dir of the program files
tempDir=$1${proDir[$i]}
pushd $tempDir > /dev/null

#run flawfinder on the program files and save the output.
echo "***${proDir[$i]}***" | tee -a "$resDir"allPrograms.txt "$resDir${proDir[$i]}"_results.txt
flawfinder $tempDir | tee -a "$resDir"allPrograms.txt "$resDir${proDir[$i]}"_results.txt
echo | tee -a "$resDir"allPrograms.txt "$resDir${proDir[$i]}"_results.txt

#change back to the dir with the programs
popd > /dev/null

done 

#change back to original dir
popd > /dev/null

