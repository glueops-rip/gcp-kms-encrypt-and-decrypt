# gcp-kms-encrypt-and-decrypt

Tool for encrypting secrets and decrypting ciphertext using GCP KMS.

## Requirements:

* GCP KMS Key
* Execute in GCP cloud shell, with necessary permissions


## Usage

### encrypting secrets

```sh
curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -a encrypt -t 'myPassword'
```

__NB__ Use single quotes when passing in secrets to avoid special characters being interpreted by bash.

### decrypting secrets

```sh
 curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -a decrypt -t 'CiQA5s3H....'
 ```

