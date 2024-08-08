#!/bin/bash

# HashCrack : Find a password with Hash SHA256 and salt
# Author    : LooXzy
# Last edit : 27/10/2022


# FONCTIONS
Help()
{
    echo "#############################################################"
    echo "####################### [ HASHCRACK ] #######################"
    echo "#############################################################"
    echo "Usage : HashCrack [option] ... [-W arg] ..."
    echo "Options and arguments :"
    echo "-h      : Show help"
    echo "-v      : Show version and author of the script"
    echo "-W arg  : Insert path to the wordlist"
    echo "-H arg  : Insert HASH (SHA256 only in version 1.0)"
    echo "-S arg  : Insert Salt"
    echo "#############################################################"
    echo "####################### [ By LooXzy ] #######################"
    echo "#############################################################"
}

Version()
{
    echo "####################"
    echo "# Script by LooXzy #"
    echo "#    HashCrack     #"
    echo "#   Version 1.0    #"
    echo "####################"
}


# MAIN
# Check command option
while getopts "W:H:S:hv" option; do #w: arg // w (sans ':') not arg
   case $option in

      W) # Enter path to the wordlist
         wordlist=$OPTARG
         ;;
      H) # Enter the hash
         hash=$OPTARG
         ;;
      S) # Enter the salt
         salt=$OPTARG
         ;;
      h) # display Help
         Help
         exit 0;;
      v) # display the version
         Version
         exit 0;;
      :) # Invalid arguments
         echo "Error: Invalid arguments"
         exit 2;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit 2;;
   esac
done

if [ ${#hash} != 64 ]
then
   echo "[!] Please use SHA256 only !"
   echo "[*] Exiting ..."
   exit 2
fi

# Display
echo "[*] Starting !"
echo "[*] Finding a Match ..."
echo ""
sleep 3

# Read the word in wordlist and compare with Hash SHA256 and salt
for ligne in $(cat $wordlist)
do
    wordAndSalt="$ligne$salt"
    hashedPass=$(echo -n $wordAndSalt| sha256sum | cut -c 1-64); # cut -d"" -f1

    if [ $hashedPass = $hash ]
    then
        echo "[*] Match found !"
        echo "[!] The password is : "$ligne
        echo ""
        echo "[*] Hash : "$hash
        echo "[*] Salt : "$salt
        echo "[*] Wordlist : "$wordlist
        exit 0
    else
        continue
    fi
    
done

echo "[!] Password not found"
echo "[*] Use an other wordlist !"