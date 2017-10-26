#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=mail
LCF=/etc/apt/listchanges.conf
CONFIRM="confirm=1"

sed -i "/$CONFIRM/d" $LCF

apt-get update && apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y

echo "$CONFIRM" >> $LCF
