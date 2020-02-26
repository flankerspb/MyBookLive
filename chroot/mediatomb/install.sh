#!/bin/sh

### mediatomb files
# mediatomb DB - /var/lib/mediatomb/mediatomb.db
# mediatomb config - /etc/mediatomb/config.xml
# mediatomb import.js - /usr/share/mediatomb/js/import.js

###
# $0 - Full scriptname
# $1 - $CHROOT_DIR
###

echo deb http://www.deb-multimedia.org jessie main non-free >> $1/etc/apt/sources.list
chroot $1 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5C808C2B65558117
chroot $1 apt-get update
chroot $1 apt-get --force-yes -qqy install mediatomb
chroot $1 /etc/init.d/mediatomb stop
chroot $1 apt-get --force-yes -qqy install ffmpegthumbnailer ffmpeg

if [ -e $(dirname $0)/config.xml ]
then
  mv $1/etc/mediatomb/config.xml $1/etc/mediatomb/config_original.xml
  cp $(dirname $0)/config.xml $1/etc/mediatomb/config.xml
  chmod +rw $1/etc/mediatomb/config.xml
fi

if [ -e $(dirname $0)/import_simple.js ]
then
  cp $(dirname $0)/import_simple.js $1/usr/share/mediatomb/js/import_simple.js
  chmod +rw $1/usr/share/mediatomb/js/import_simple.js
fi
