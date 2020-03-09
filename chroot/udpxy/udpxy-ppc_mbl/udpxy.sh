#!/bin/sh
### BEGIN INIT INFO
# Provides:          udpxy
# Required-Start:    $network $local_fs $remote_fs
# Required-Stop:     $network $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start udpxy at boot time
# Description:
### END INIT INFO

### PARAMS
# -a - интерфейс, который будет слушать udpxy в ожидании tcp-запросов (внутренняя сетевая карта);
# -m - интерфейс, на который приходит мультикаст (внешняя сетевая карта);
# -p - tcp-порт, на котором висит udpxy;
# -B - размер буфера;
# -S - вести статистику соединений;
# -l - указание пути к файлу логов.
# -c - колличество клиентов, имеющих возможность одновременно использовать ip-tv.
###

NAME=`basename $0`
DROOT=/usr/bin
DAEMON=${DROOT}/udpxy
ARG=$1
PARAMS="-a eth0 -p 4022 -B 2mb -m eth0 -M 30"

cd ${DROOT}

if [ "$#" -ne 1 ]; then
 ARG="start"
fi

case ${ARG} in
 start) ${DAEMON} ${PARAMS} ;;
 stop) start-stop-daemon -K -x ${DAEMON} -q ;;
 *) echo "Usage: `basename $0` start|stop" ;;
esac

exit 0;
