Как записать на диск прошивку (процесс «раскирпичивание»)?:
Для раскирпичивания понадобится этот скрипт (http://files.ryzhov-al.ru/WD%20My%20Book%20Live/debricker/debricker.sh) и LiveCD/LiveUSB дистрибутив, например, Ubuntu. Безопасней всего отключить в ПК все имеющиеся SATA-диски, подключить единственный диск, который будет использоваться в MBL и загрузить Live-дистрибутив. В случае Ubuntu, откройте консоль, где установите недостающий пакет mdadm, скрипт раскирпичивания и последнюю прошивку:

код:
---
cd ~
sudo apt-get update
sudo apt-get install mdadm
wget http://files.ryzhov-al.ru/WD%20My%20Book%20Live/debricker/debricker.sh

//wget http://download.wdc.com/nas/apnc-024309-038-20141208.deb
//dpkg -x ./apnc-024309-038-20141208.deb  ~

wget http://download.wdc.com/nas/apnc-024310-048-20150507.deb
dpkg -x ./apnc-024310-048-20150507.deb  ~
---


Запустив скрипт без параметров можно получить справку по его работе. Пример восстановления подключенного диска (/dev/sda):

код:
---
sudo bash ./debricker.sh /dev/sda ~/CacheVolume/upgrade/rootfs.img
---

После того как скрипт отработает, надо корректно завершить работу загруженной Live-системы. Диск готов для установки в MBL.
