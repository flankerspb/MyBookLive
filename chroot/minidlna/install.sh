#!/bin/sh

# PID file - /DataVolume/debian/run/minidlna/minidlna.pid
# DataBase file - /var/cache/minidlna

###
# $0 - Full scriptname
# $1 - $chrootBaseDir
###

chroot $1 apt-get --force-yes -qqy install minidlna
killall minidlna > /dev/null 2>&1

if [ -e $(dirname $0)/minidlna.conf ]
then
  mv $1/etc/minidlna.conf $1/etc/minidlna_original.conf
  cp $(dirname $0)/minidlna.conf $1/etc/minidlna.conf
  chmod +rw $1/etc/minidlna.conf
fi

rm -f $1/var/lib/minidlna/files.db
