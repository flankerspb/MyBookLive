#!/bin/sh

### For example
# sh /shares/test/chroot/install.sh

INFO="\033[1;36mInfo:\033[0m"
ERROR="\033[1;31mError:\033[0m"
WARNING="\033[1;33mWarning:\033[0m"
NOTICE="\033[1;33mNotice:\033[0m"
INPUT="\033[1;37m====>:\033[0m"
DONEs="\033[1;32m"
DONEe=":\033[0m"
DONE="\033[1;32mDone:\033[0m"

#CURR_PATH=$(dirname $0)
CURR_PATH=$(dirname $(readlink -e $0))

#############################################

if [ -z $1 ]
then
  CHROOT_NAME=debian
else
  CHROOT_NAME=$1
fi

CHROOT_DIR=/DataVolume/$CHROOT_NAME
PACKAGE=debootstrap_1.0.89~bpo8+1_all.deb
CODE_NAME=jessie

#############################################

echo -e $INFO "This script will guide you through the chroot-based services
      installation on WD My Book Live \(Duo\) and My Cloud NAS.
      The goal is to install Debian $CODE_NAME environment with no interference
      with firmware. You will be asked later about which services to install."

echo -en $INPUT Would you like continue [y/n]?
read userAnswer
if [ "$userAnswer" != "y" ]
then
  echo -e $INFO Ok then. Exiting.
  exit 0
fi

if [ -e /etc/init.d/chroot_$CHROOT_NAME.sh ]
then
  echo -e $ERROR "Chroot\'ed services start/stop script detected! Please, remove
       previous installation or specify destination folder name
       and run script again with folder name parameter, for example:
       install.sh my_debian"
  exit 1
fi

if [ -d $CHROOT_DIR ]
then
  echo -e $WARNING Previous chroot environment will be moved to $CHROOT_DIR.old
  [ -d $CHROOT_DIR.old ] || mkdir $CHROOT_DIR.old
  mv -f $CHROOT_DIR/* $CHROOT_DIR.old
else
  mkdir $CHROOT_DIR
fi

echo -e $INFO Deploying a debootstrap package...
dpkg -i $CURR_PATH/$PACKAGE
echo -e $INFO "Preparing a new Debian $CODE_NAME chroot file base. Please, be patient,
      may takes a long time on low speed connection..."

debootstrap --no-check-gpg --no-check-certificate --variant=minbase --exclude=yaboot,udev,dbus,systemd --include=locales,mc,aptitude,wget,dialog,apt-utils,sysvinit,sysvinit-utils $CODE_NAME $CHROOT_DIR http://archive.debian.org/debian/

echo "share:x:1000:root,www-data,daapd" >> $CHROOT_DIR/etc/group
cat > $CHROOT_DIR/usr/sbin/policy-rc.d <<EOF
#!/bin/sh
exit 101
EOF
chmod a+x $CHROOT_DIR/usr/sbin/policy-rc.d

sed -e "s/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/" -e "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" $CHROOT_DIR/etc/locale.gen > $CHROOT_DIR/etc/locale.gen.sed
cp -f $CHROOT_DIR/etc/locale.gen.sed $CHROOT_DIR/etc/locale.gen
chroot $CHROOT_DIR locale-gen
chroot $CHROOT_DIR apt-get update > /dev/null 2>&1
echo -e $INFO A Debian $CODE_NAME chroot environment  installed.

echo -e $INFO Now deploying services start script...
cp -f $CURR_PATH/template_chroot.sh $CHROOT_DIR/chroot_$CHROOT_NAME.sh
eval sed -i 's,__CHROOT_DIR_PLACEHOLDER__,$CHROOT_DIR,g' $CHROOT_DIR/chroot_$CHROOT_NAME.sh
chmod +x $CHROOT_DIR/chroot_$CHROOT_NAME.sh
touch $CHROOT_DIR/chroot-services.list
$CHROOT_DIR/chroot_$CHROOT_NAME.sh install
echo >> $CHROOT_DIR/root/.bashrc
echo PS1=\'\(chroot-$CHROOT_NAME\)\\w\# \' >> $CHROOT_DIR/root/.bashrc
$CHROOT_DIR/chroot_$CHROOT_NAME.sh start
echo -e $INFO chroot environment ready.

echo -en $INPUT Would you like install services [y/n]?
read userAnswer
if [ "$userAnswer" == "y" ]
then
  
  isNeedRestart=no
  subdirs="$(ls -d $CURR_PATH/*/)"
  
  for subdir in $subdirs; do
    
    service=$(basename $subdir)
    installer=$subdir'install.sh'
    
    if [ -e $installer ]
    then
      
      echo -en $INPUT Would you like install "\033[1;37m"$service"\033[0m"? [y/n]?
      read userAnswer
      if [ "$userAnswer" == "y" ]
      then
        sh $installer $CHROOT_DIR
        echo $service >> $CHROOT_DIR/chroot-services.list
        echo -e $INFO "\033[1;37m"$service"\033[0m" installed.
        isNeedRestart=yes
      else
        echo -e $INFO "\033[1;37m"$service"\033[0m" installation canceled.
      fi
    else
      echo -e $NOTICE "\033[1;37m"$service"\033[0m" installation script not found!
    fi
  done

  if [ "$isNeedRestart" == "yes" ]
  then
    echo -en $INPUT Would you like start chroot\'ed services right now [y/n]?
    read userAnswer
    if [ "$userAnswer" == "y" ]
    then
      /etc/init.d/chroot_$CHROOT_NAME.sh stop
      sleep 5
      /etc/init.d/chroot_$CHROOT_NAME.sh start
    fi
  fi
  
fi

echo -e $DONEs...finished.$DONEe
