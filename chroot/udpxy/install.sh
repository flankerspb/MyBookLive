#!/bin/sh

###
# $0 - Full scriptname
# $1 - $chrootBaseDir
#
# /mnt/Public/udpxy/
# http://mybooklive:4022/status
# http://mybooklive:4022/restart
###


mkdir $(dirname $0)/install
cd $(dirname $0)/install
tar -xvf ../udpxy-ppc_mbl.tar
chmod 755 udpxy
chmod 755 udpxrec
chmod 755 udpxy.sh
mv udpxy $1/usr/bin/udpxy
mv udpxrec $1/usr/bin/udpxrec
mv udpxy.sh $1/etc/init.d/udpxy
cd
rm -R $(dirname $0)/install
chroot $1 update-rc.d -f udpxy defaults 40
