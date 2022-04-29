
#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -e enviroment -a encrypt -t pass1234"
   echo " -e environment (ex. development, uat, production)"
   echo " -a action (ex. encrypt or decrypt)"
   echo " -t plaintext or chipertext"
   exit 1 # Exit script after printing help
}

while getopts "e:a:t:" opt
do
   case "$opt" in
      e ) parameterE="$OPTARG" ;;
      a ) parameterA="$OPTARG" ;;
      t ) parameterT="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$parameterE" ] || [ -z "$parameterA" ] || [ -z "$parameterT" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi


key=`gcloud kms keys list --keyring=$parameterE --location=global --format=json | jq .[0].name -r`
if [ "encrypt" = "${parameterA,,}" ]; then
PLAINTEXT=$parameterT
echo "Encrypting Text: $PLAINTEXT"
ENCRYPTED=`curl -s "https://cloudkms.googleapis.com/v1/$key:encrypt" \
  -d "{\"plaintext\":\"$(echo $PLAINTEXT | base64)\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type:application/json" \
| jq .ciphertext -r`

echo "Base64 Encrypted Text: $ENCRYPTED"
fi

if [ "decrypt" == "${parameterA,,}" ]; then
ENCRYPTED_TEXT=$parameterT
DECRYPTED=`curl -s "https://cloudkms.googleapis.com/v1/$key:decrypt" \
  -d "{\"ciphertext\":\"$ENCRYPTED_TEXT\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type:application/json" \
| jq .plaintext -r`

echo "Decrypted Text: $(echo $DECRYPTED | base64 -d)"
fi
