#!/bin/bash
function generateKey(){
randomiser=$(shuf -i 1-4 -n 1)
case $randomiser in
 1)
 #MD5 Hash
 echo -n $1 | md5sum | cut -d' ' -f1;;
 2)
 #Base64 String
 echo -n $1 | base64 | cut -d' ' -f1;;
 3)
 #SHA512 Hash
 echo -n $1 | sha512sum | cut -d' ' -f1;;
 4)
 #SHA1 Hash
 echo -n $1 | sha1sum | cut -d' ' -f1;;
esac
}

function challangeSetup(){
if [[ ! -d /home/$USER/Desktop/EncryptionChallange ]]; then
 mkdir /home/$USER/Desktop/EncryptionChallange
 cd /home/$USER/Desktop/EncryptionChallange
else
 cd /home/$USER/Desktop/EncryptionChallange
fi

for i in {1..5}; do
 touch File$i.txt
 partialKey=$(tr -dc A-Za-z </dev/urandom | head -c 16)
 if [[ $i -eq 1 ]]; then
  key=$(generateKey $partialKey)
  echo "The partial key for the first file is $partialKey"
  next_key=$(generateKey $partialKey)
  echo "Here is the partial key for the next file $partialKey" > File$i.txt
  ccrypt -f "File$i.txt" -K "$key" > /dev/null 2>&1
 elif [[ $i -eq 5 ]]; then
  key=$next_key
  echo "You decrypted all the files! Well done!" > File$i.txt
  ccrypt -f "File$i.txt" -K "$key" > /dev/null 2>&1
 else
  key=$next_key
  next_key=$(generateKey $partialKey)
  echo "Here is the partial key for the next file $partialKey" > File$i.txt
  ccrypt -f "File$i.txt" -K "$key" > /dev/null 2>&1
 fi
done
echo "The files are ready. Have fun and good luck!"
}

challangeSetup