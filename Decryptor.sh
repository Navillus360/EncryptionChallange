#!/bin/bash
if [ $# -le 1 ]; then
 echo "Error: Not enough arguments passed !Expected arguments <File name> <Key>"
 fileName=""
 key=""
 read -p "Enter the File you wish to decrypt: " fileName
 read -p "Enter the key to decrypt the file with: " key
 ccdecrypt -f "/home/$USER/Desktop/EncryptionChallange$fileName" -K "$key"
else
 ccdecrypt -f "/home/$USER/Desktop/EncryptionChallange$1" -K "$2"
fi 