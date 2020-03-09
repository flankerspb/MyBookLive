#!/bin/sh

###
# $0 - Full scriptname
# $1 - $chrootBaseDir
#
# /mnt/Public/udpxy/
# http://mybooklive:4022/status
# http://mybooklive:4022/restart
###

cp $(dirname $0)/udpxy-ppc_mbl/udpxy $1/usr/bin/udpxy
cp $(dirname $0)/udpxy-ppc_mbl/udpxrec $1/usr/bin/udpxrec
cp $(dirname $0)/udpxy-ppc_mbl/udpxy.sh $1/etc/init.d/udpxy
chmod 755 $1/usr/bin/udpxy
chmod 755 $1/usr/bin/udpxrec
chmod 755 $1/etc/init.d/udpxy
