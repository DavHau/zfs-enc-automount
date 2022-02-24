#!/usr/bin/env bash

# Enter your encrypted datasets here
provider_host="10.99.99.2"
enc_datasets=$(zfs get -r -H -o name,value keyformat | grep passphrase | awk '{print $1}' | xargs)

set -e
for ds in $enc_datasets; do
  location="/run/zfs_passwords/$ds"
  passwd=$(ssh root@$provider_host cat $location)
  echo $passwd | zfs load-key $ds && echo "key loaded successfully"
done
zfs mount -a && echo "all datasets mounted successfully"
exit $?
