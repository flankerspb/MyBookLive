# Установка и настройка UDP-прокси UDPXY

> [UDPXY](http://www.udpxy.com/)– серверное приложение (daemon) для передачи данных из сетевого потока мультикаст канала (вещаемого по UDP) в HTTP-соединение запрашивающего клиента.

### Автоматическая установка

> Установка UDPXY производится автоматически во время развертывания [chroot-среды](../).

> Также автоматическую установку можно запустить отдельно. Скачиваем [архив репозитория](https://github.com/FLANKERSPb/MyBookLive/archive/master.zip), распаковываем и закидываем на MBL в любую папку шары.

Пример установки в chroot-среду `/DataVolume/debian/` из папки шары `Public` :

    MyBookLive:~# sh /shares/Public/chroot/udpxy/install.sh /DataVolume/debian

### Ручная установка

Подключаемся к MBL по SSH и переключаемся в chroot-среду:

    MyBookLive:~# chroot /DataVolume/debian/
    (chroot-debian)/#

Распаковываем архив `udpxy-ppc_mbl.tar`, устанавливаем файлам необходимые права и перемещаем их в соответствующие папки.

    (chroot-debian)/# mkdir /mnt/Public/udpxy/install
    (chroot-debian)/# cd /mnt/Public/udpxy/install
    (chroot-debian)/# tar -xvf ../udpxy-ppc_mbl.tar
    (chroot-debian)/# chmod 755 udpxy
    (chroot-debian)/# chmod 755 udpxrec
    (chroot-debian)/# chmod 755 udpxy.sh
    (chroot-debian)/# mv udpxy /usr/bin/udpxy
    (chroot-debian)/# mv udpxrec /usr/bin/udpxrec
    (chroot-debian)/# mv udpxy.sh /etc/init.d/udpxy

Чтобы UDPXY загружался вместе с системой добавляем в файл `/chroot-services.list` 
строку `udpxy`:

    (chroot-debian)/# echo udpxy >> /chroot-services.list

### Параметры запуска

`-a` - интерфейс, который будет слушать udpxy в ожидании tcp-запросов;
`-m` - интерфейс, на который приходит мультикаст;
`-p` - tcp-порт, на котором висит udpxy;
`-B` - размер буфера;
`-S` - вести статистику соединений;
`-l` - указание пути к файлу логов.
`-c` - колличество клиентов, имеющих возможность одновременно использовать ip-tv.

> По умолчанию прописаны следующие параметры `-a eth0 -p 4022 -B 2mb -m eth0  -M 30`. При необходимости их можно изменитьв файле `/etc/init.d/udpxy`.

### Управление и настройка

Базовая статистика udpxy - http://mybooklive:4022/status

Закрыть все активные соединения и перезапустить - http://mybooklive:4022/restart

Команды запуска/остановки/перезапуска MediaTomb:

    (chroot-debian)/# /etc/init.d/udpxy start
    (chroot-debian)/# /etc/init.d/udpxy stop