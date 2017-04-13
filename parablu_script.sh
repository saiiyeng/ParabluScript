#!/bin/sh

echo "Starting Installation " >> /tmp/BAAS_Install_Boot.log
sudo -i
whoami
ls
sed -i -e 's/Defaults requiretty.*/ #Defaults requiretty/g' /etc/sudoers  
yum install ftp -y >> /tmp/BAAS_Install_Boot.log 2>&1
yum install expect -y >> /tmp/BAAS_Install_Boot.log 2>&1
yum install unzip -y >> /tmp/BAAS_Install_Boot.log 2>&1

sed -i "2i169.47.193.14   SELECTTEST.BAASTEST.COM" /etc/hosts >> /tmp/BAAS_Install_Boot.log 2>&1 

mkdir /tmp/Installer
cd /tmp/Installer
curl -O https://raw.githubusercontent.com/invhariharan/baas-scripts/master/scripts/GSMA_functions.sh  >> /tmp/BAAS_Install_Boot.log 2>&1
curl -O https://raw.githubusercontent.com/invhariharan/baas-scripts/master/scripts/enable_tsm_on_linux.sh  >> /tmp/BAAS_Install_Boot.log 2>&1
curl -O https://raw.githubusercontent.com/invhariharan/baas-scripts/master/scripts/enable_tsm_on_linux.param >> /tmp/BAAS_Install_Boot.log 2>&1



sudo chmod +x * >> /tmp/BAAS_Install_Boot.log 2>&1
sudo ./enable_tsm_on_linux.sh --install-and-configure -dip >> /tmp/BAAS_Install_Boot.log 2>&1
echo "Completed Installation " >> /tmp/BAAS_Install_Boot.log
