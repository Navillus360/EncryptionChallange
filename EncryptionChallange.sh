partialKey=""

function generateKey(){
randomiser=$(shuf -i 1-3 -n 1)
case $randomiser in
 1)
 #MD5 Hash
 partialKey=$(tr -dc A-Za-z </dev/urandom | head -c 16)
 return $partialKey | md5sum;;
 2)
 #Base64 String
 partialKey=$(tr -dc A-Za-z </dev/urandom | head -c 16)
 return $partialKey | base64;;
 3)
 #Sha512 Hash
 partialKey=$(tr -dc A-Za-z </dev/urandom | head -c 16)
 return $partialKey | sha512sum;;
 4)
 #Sha1 Hash
 partialKey=$(tr -dc A-Za-z </dev/urandom | head -c 16)
 return $partialKey | sha1sum;;
esac
}

function challangeSetup(){
#Creates a directory within the desktop to make it easier to access the files
if [[ ! -d "/home/$USER/Desktop/EncryptionChallange" ]]; then
 mkdir /home/$USER/Desktop/EncryptionChallange
 cd /home/$USER/Desktop/EncryptionChallange
else
 cd /home/$USER/Desktop/EncryptionChallange
fi

#Creates the first file and echos its partial password to get the user going
touch File1.txt
key="$(generateKey)" | echo "$partialKey" > File1.txt
ccrypt -f "File1.txt" -K "$key" > /dev/null 2&1
echo "The partial password for File1 is $partialKey"

for (( i = 1 ; i <=4 ; i++)); do 
 key="$(generateKey)"
 touch File$i.txt | echo "$partialKey" > File$i.txt
 ccrypt -f "$file" -K "$key" > /dev/null 2&1
done
echo "Files ready. Have fun and good luck!"
}

challangeSetup()