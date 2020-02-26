#!/bin/sh

###
# $0 - Full scriptname
# $1 - $chrootBaseDir
###

chroot $1 apt-get --force-yes -qqy install transmission-daemon
chroot $1 apt-get --force-yes -qqy install cron

[ -d /DataVolume/shares/Public/Torrents ] || mkdir /DataVolume/shares/Public/Torrents
echo -e Torrents content will be downloaded to \"Public/Torrents\".

if [ -e $(dirname $0)/settings.json ]
then
  cp $(dirname $0)/settings.json $1/etc/transmission-daemon/settings.json
  chmod +rw $1/etc/transmission-daemon/settings.json
fi


