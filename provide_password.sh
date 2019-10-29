#!/usr/bin/env bash

provider_host="10.99.99.2"

read -s passwd
ssh root@$provider_host "echo $passwd > /run/zfs_passwd"
