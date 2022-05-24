# gcp-kms-encrypt-and-decrypt

This tool bundles various `gcloud` and `bash` commands necessary to encrypt and decrypt secrets.  The tool is designed to be used with either cloud shell in the GCP console or with a local installation of the `gcloud` tool and the necessary local keyfiles.

The recommended path is to use the GCP console to avoid managing a local environment and toolchain.


## Requirements:

* A GCP KMS Key in the project where you're encrypting or decrypting secrets.
* Permission to use the `roles/cloudkms.cryptoKeyEncrypterDecrypter` role within the relevant project.
* The secret values to encrypt or ciphertext to decrypt.


## Usage

### encrypting secrets

Use the following command to encrypt a secret, replacing `myPassword` with the plaintext secret value you would like to encrypt.

```sh
curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -a encrypt -t 'myPassword'
```

__NB__ Use single quotes when passing in secrets to avoid special characters being interpreted by bash.

### decrypting secrets

Use the following command to decrypt ciphertext, replacing `CiQA5s3H....` with the ciphertext you would like to decrypt.

```sh
 curl -s https://raw.githubusercontent.com/GlueOps/gcp-kms-encrypt-and-decrypt/main/gked.sh | bash -s -- -a decrypt -t 'CiQA5s3H....'
 ```

