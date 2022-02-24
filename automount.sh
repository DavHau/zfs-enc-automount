#!/usr/bin/env bash

# Enter your encrypted datasets here
enc_datasets="pool11/enc rpool/enc"
provider_host="10.99.99.2"

set -e
for ds in $enc_datasets; do
  location="/run/zfs_passwords/$ds"
  passwd=$(ssh root@$provider_host cat $location)
  echo $passwd | zfs load-key $ds && echo "key loaded successfully"
done
zfs mount -a && echo "all datasets mounted successfully"
exit $?
