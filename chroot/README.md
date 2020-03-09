# Установка и использование chroot-среды

## Установка

Скачиваем [архив репозитория](https://github.com/FLANKERSPb/MyBookLive/archive/master.zip), распаковываем и закидываем на MBL в любую папку шары. Например в `Public`.

Включаем SSH доступ в web-интерфейсе устройства.
* http://mybooklive/UI/ssh - для My Book Live
* http://mybookliveduo/UI/ssh - для My Book Live DUO

Подключаемся к SSH-консоли устройства, с помощью любого ssh-клиента, например [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html). Вводим логин и пароль.

> По умолчанию Имя пользователя - `root`, пароль - `welc0me` (0 - цифра).

Если все сделали правильно, появится приглашение к работе.

    MyBookLive:~#

Установливаем chroot-среду:

    MyBookLive:~# sh /shares/Public/chroot/install.sh

Начнётся установка базового набора файлов дистрибутива **Debian Jessie**, которая может занят от 20 до 40 минут. После чего можно будет установить [медиасервер miniDLNA](minidlna), [медиасервер MediaTomb](mediatomb), [торрент-клиент Transmission](transmission) и/или [UDP-прокси UDPXY](udpxy) и запустить их без перезагрузки устройства.

Скрипт установки прописывает всё необходимое для запуска выбранных сервисов в сhroot-среде.

> Сервисы, которые необходимо запустить при включении My Book Live перечислены в файле `/DataVolume/debian/chroot-services.list`, по одному сервису в строке. Это имена файлов из папки `/DataVolume/debian/etc/init.d`.

## Использование

Даже если никаких сервисов в chroot-среде пока не запускается, перед входом в неё необходимо выполнить скрипт запуска для монтирования необходимых каталогов:

    MyBookLive:~# /etc/init.d/chroot_debian.sh start

Вход

    MyBookLive:~# chroot /DataVolume/debian

выход 

    (chroot-debian)~# exit
    MyBookLive:~#

Остановка

    MyBookLive:~# /etc/init.d/chroot_debian.sh stop


Выполнив `ls /` вы поймёте, что уже не в окружении прошивки. Так же изменилось приглашение с `MyBookLive:~#` на `(chroot-debian)~#`. 

Здесь уже можно без боязни выполнять `apt-get update`, устанавливать, конфигурировать или удалять любые пакеты: перед вами полноценный дистрибутив Debian Stable, который можно использовать практически без ограничений. Из-за того, что всё происходит в изолированной "песочнице", файлам прошивки навредить не выйдет при всём желании. После окончания конфигурирования новых сервисов не забудьте внести их имена в `chroot-services.list`. Для выхода из chroot-среды выполните `exit` и вы вернётесь в привычное окружение прошивки.

## Воостановление автостарта после обновления прошивки
Необходимо вернуть на законное место скрипт запуска chroot-сервисов:

    /DataVolume/debian/chroot_debian.sh install

Удаление chroot-среды

    /etc/init.d/chroot_debian.sh stop
    /etc/init.d/chroot_debian.sh remove

Перегрузите WD My Book Live и удалите все файлы Debian Jessie

    rm -fr /DataVolume/debian/

