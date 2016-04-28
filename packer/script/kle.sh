apt-get -y remove nano vim-tiny nfs-common rpcbind procmail mutt systemd
apt-get -y install vim-nox git locales-all sudo

>/etc/motd

update-rc.d -f motd remove

sed -i "s/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/" /etc/sudoers

useradd --home-dir /home/petr --create-home --comment "Petr" --gid users --groups sudo --shell /bin/bash petr --uid 1300

echo petr:`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c15` | chpasswd

mkdir /home/petr/.ssh

echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAzjuQ1B7XYD32/rYtxJvoTxTJ28AI7Nl4f2X7kmYJ7ahR0koilS18MfXphnujYI2huF2n+yWFQiqNLT5rVCwOkr67WvkFpTWTOCFvMAtawokv1DF4rujNe3GD3K2NtxJePZvcMzmaek0ERy07f74mta1SN12FPH15zbQ/ZLocr/6qjo4QlYy16ESKkeGA7uuWYBUk8HfzYCO7tgwKEhhHLqCD52/XSWNtd0Q8NVzi1SibCbkZCWNn79Yjcvr57lI2/tVJmaY3ruQ49wTW+qpXDfcXWStBumlwH97d57JQ7UrQ81AYFSmZcw4EdMbCKEzlU6BifodW5gcXblYwHI4U4w== Petr' > /home/petr/.ssh/authorized_keys

chown -R petr:users /home/petr/.ssh
chmod -R og-rwx /home/petr/.ssh
