# Установка медиа-сервера MediaTomb в chroot среду

> MediaTomb (свободный сервер UPnP) отсутствует в родных репозиториях Jessie, был удален из репозиториев по причине незакрытой уязвимости, так что используйте дальнейшее руководство на свой страх и риск.

В веб-интерфейсе MBL(D) разделе `Settings->Media->Twonky` отключаем "Twonky Service" и останавливаем работу службы Twonky сервера.

    MyBookLive:~# /etc/init.d/twonky stop

Добавляем в /etc/apt/sources.list следующую запись:

    deb http://www.deb-multimedia.org jessie main non-free

Переключаемся в chroot-среду и обновляем информацию из репозиториев:

    MyBookLive:~# chroot /DataVolume/debian/
    (chroot-debian)/# sudo apt-get update
    

Запускаем установку MediaTomb:
    
    (chroot-debian)/# sudo apt-get install mediatomb
    
При необходимости установливаем пакеты ffmpegthumbnailer и ffmpeg для отображения тумбнейлов:

    (chroot-debian)/# sudo apt-get install ffmpegthumbnailer ffmpeg

Чтобы MediaTomb загружался вместе с системой добавляем в файл `/chroot-services.list` строку

    mediatomb

Для удобства создаем для папок шары симлинки в 

    ***************************
    
Для управления MediaTomb используем команды:

    (chroot-debian)/# /etc/init.d/mediatomb start
    (chroot-debian)/# /etc/init.d/mediatomb stop
    (chroot-debian)/# /etc/init.d/mediatomb restart


> Для корректной работы сервера необходимо произвести настройку конфига (/etc/mediatomb/config.xml): об этом много написано в сети, и останавливаться я на этом не буду (пример моего конфига под спойлером).

Теперь можно зайти в web-интерфейс медиасервера http://mybooklive:49152/

  

