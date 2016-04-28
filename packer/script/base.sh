sed -i "/^deb cdrom:/s/^/#/" /etc/apt/sources.list

sed -i "s/ main/ main contrib non-free/" /etc/apt/sources.list

apt-get -y update
apt-get -y upgrade
apt-get -y install curl
apt-get clean
