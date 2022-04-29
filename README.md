# gcp-kms-encrypt-and-decrypt

Tool for encrypting secrets and decrypting ciphertext using GCP KMS.

## Requirements:

* GCP KMS Key
* Execute in GCP cloud shell, with necessary permissions


## Usage

### encrypting secrets

```sh
curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -e development -a encrypt -t 'myPassword'
```

__NB__ Use single quotes when passing in secrets to avoid special characters being interpreted by bash.

### decrypting secrets

```sh
 curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -e development -a decrypt -t 'CiQA5s3HX/Wjy3r5T1zQ1ON9EhdsUzekcVNylBTlPVFL14rieJcSLwB5Z707acpNZjgS2rtRfDpcHKc+sUgg8IIvWMSvhNvhW49E9pgxKrCEexnNd6uC'
 ```

