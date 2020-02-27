# Медиа-сервер MediaTomb

> MediaTomb (свободный сервер UPnP) отсутствует в родных репозиториях Jessie, был удален из репозиториев по причине незакрытой уязвимости, так что используйте дальнейшее руководство на свой страх и риск.

### Автоматическая установка

> Установка MediaTomb производится автоматически во время развертывания [chroot-среды](../). При этом подменяются оригинальные файлы [конфигурации](config.xml) и [импорта](import_simple.js) файлами из текущей папки. Чтобы этого не произошло, просто удаляем их. Автоматическую установку также можно запустить отдельно.

Пример установки в chroot-среду `/DataVolume/debian/` из папки шары `Public` :

    MyBookLive:~# sh /shares/Public/chroot/mediatomb/install.sh /DataVolume/debian

### Ручная установка

Подключаемся к MBL по SSH и переключаемся в chroot-среду:

    MyBookLive:~# chroot /DataVolume/debian/
    (chroot-debian)/#

Добавляем репозиторий и ключ к нему:
    
    (chroot-debian)/# echo deb http://www.deb-multimedia.org jessie main non-free >> /etc/apt/sources.list
    (chroot-debian)/# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5C808C2B65558117

 Обновляем информацию о пакетах из репозиториев и устанавливаем MediaTomb:
    
    (chroot-debian)/# apt-get update
    (chroot-debian)/# apt-get install mediatomb

Для отображения превьюшек можно установить пакеты `ffmpegthumbnailer` и `ffmpeg`:
    
    (chroot-debian)/# apt-get ffmpegthumbnailer ffmpeg

Чтобы MediaTomb загружался вместе с системой добавляем в файл `/chroot-services.list` строку `mediatomb`:

    (chroot-debian)/# echo mediatomb >> /chroot-services.list
    
> Не забываем отключить Twonky в веб-интерфейсе MBL(D) в разделе `Settings->Media->Twonky`.
    
### Управление и настройка

Web-интерфейс MediaTomb - http://mybooklive:49152/

Команды запуска/остановки/перезапуска MediaTomb:

    (chroot-debian)/# /etc/init.d/mediatomb start
    (chroot-debian)/# /etc/init.d/mediatomb stop
    (chroot-debian)/# /etc/init.d/mediatomb restart


Расположение файла конфигурации MediaTomb:
    
    /etc/mediatomb/config.xml

Расположение файла базы данных MediaTomb:
    
    /var/lib/mediatomb/mediatomb.db

Расположение файла импорта MediaTomb:
    
    /usr/share/mediatomb/js/import.js
