# Раскирпичивание

Для раскирпичивания нам понадобится:

- Непосредственно [скрипт раскирпичивания](debricker.sh);
- LiveCD/LiveUSB дистрибутив, например, [Ubuntu](https://ubuntu.com/download/desktop);
- Последняя прошивка для [My Book Live](https://support-en.wd.com/app/products/product-detail/p/231#WD_downloads) или [My Book Live Duo](https://support-en.wd.com/app/products/product-detail/p/232#WD_downloads);
 
> Безопасней всего отключить в ПК все имеющиеся SATA-диски, подключить единственный диск, который будет использоваться в MBL(D) и загрузить Live-дистрибутив.

>В случае Ubuntu, откройте консоль, где установите недостающий пакет mdadm, скрипт раскирпичивания и последнюю прошивку.

Устанавливем mdadm:

    cd ~
    sudo apt-get update
    sudo apt-get install mdadm

Качаем скрипт раскирпичивания:

    wget https://github.com/FLANKERSPb/MyBookLive/blob/master/debrick/debricker.sh

Качаем и распаковываем последнюю прошивку для My Book Live:

    wget http://download.wdc.com/nas/apnc-024310-048-20150507.deb
    dpkg -x ./apnc-024310-048-20150507.deb  ~
    
или для My Book Live Duo:

    wget http://download.wdc.com/nas/ap2nc-024310-048-20150507.deb
    dpkg -x ./ap2nc-024310-048-20150507.deb  ~

Запустив скрипт с параметром `--help` можно получить справку по его работе:

    sudo bash ./debricker.sh --help

Восстановление прошивки с сохранением данных пользователя для диска - ` /dev/sda `:

    sudo bash ./debricker.sh /dev/sda ~/CacheVolume/upgrade/rootfs.img
      
Накатка прошивки с пересозданием разделов для новых/неразмечаных дисков  - ` /dev/sda `:

      sudo bash ./debricker.sh /dev/sda ~/CacheVolume/upgrade/rootfs.img destroy


> После того как скрипт отработает, надо корректно завершить работу загруженной Live-системы. Диск готов для установки в MBL.
