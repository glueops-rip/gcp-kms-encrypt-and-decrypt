
#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -a encrypt -t 'pass@1234'"
   echo " -a action (ex. encrypt or decrypt)"
   echo " -t plaintext or chipertext"
   exit 1 # Exit script after printing help
}

while getopts "a:t:" opt
do
   case "$opt" in
      a ) parameterA="$OPTARG" ;;
      t ) parameterT="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$parameterA" ] || [ -z "$parameterT" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi


keyring=`gcloud kms keyrings list --location=global --format=json | jq .[0].name -r`
key=`gcloud kms keys list --keyring=$keyring --location=global --format=json | jq .[0].name -r`
if [ "encrypt" = "${parameterA,,}" ]; then
PLAINTEXT=$parameterT
echo "Encrypting Text: $PLAINTEXT"
ENCRYPTED=`curl -s "https://cloudkms.googleapis.com/v1/$key:encrypt" \
  -d "{\"plaintext\":\"$(echo $PLAINTEXT | base64 -w 0)\"}" \
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
