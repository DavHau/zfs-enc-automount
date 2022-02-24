#!/usr/bin/env bash

provider_host="10.99.99.2"
enc_datasets=$(zfs get -r -H -o name,value keyformat | grep passphrase | awk '{print $1}' | xargs)

for ds in $enc_datasets; do
  location="/run/zfs_passwords/$ds"
  echo "please enter password for $ds:"
  read -s passwd
  ssh root@$provider_host mkdir -p $(dirname $location)
  ssh root@$provider_host "echo $passwd > $location"
done
