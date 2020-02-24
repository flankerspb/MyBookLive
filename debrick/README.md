# Раскирпичивание

Для раскирпичивания понадобится

- [скрипт](debricker.sh)
- LiveCD/LiveUSB дистрибутив, например, [Ubuntu](debricker.sh)
- последняя прошивка [MBL](debricker.sh) или [MBLD](debricker.sh)
 
> Безопасней всего отключить в ПК все имеющиеся SATA-диски, подключить единственный диск, который будет использоваться в MBL и загрузить Live-дистрибутив. В случае Ubuntu, откройте консоль, где установите недостающий пакет mdadm, скрипт раскирпичивания и последнюю прошивку.

устанавливем mdadm

    cd ~
    sudo apt-get update
    sudo apt-get install mdadm

скрипт раскирпичивания

    wget http://files.ryzhov-al.ru/WD%20My%20Book%20Live/debricker/debricker.sh

последнюю прошивку My Book Live

    wget http://download.wdc.com/nas/apnc-024310-048-20150507.deb
    dpkg -x ./apnc-024310-048-20150507.deb  ~
    
последнюю прошивку My Book Live Duo

    wget http://download.wdc.com/nas/apnc-024310-048-20150507.deb
    dpkg -x ./apnc-024310-048-20150507.deb  ~

Запустив скрипт без параметров можно получить справку по его работе

    dpkg -x ./apnc-024310-048-20150507.deb  ~

Пример восстановления подключенного диска (/dev/sda):

    sudo bash ./debricker.sh /dev/sda ~/CacheVolume/upgrade/rootfs.img


> После того как скрипт отработает, надо корректно завершить работу загруженной Live-системы. Диск готов для установки в MBL.
