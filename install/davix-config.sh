#!/bin/bash

## Turning off services by default
# byeybe apache
update-rc.d apache2 disable
# goodbye mysql
echo manual >> /etc/init/mysql.override
# gone is ssh and some more
echo manual >> /etc/init/ssh.override
echo manual >> /etc/init/cups.override
echo manual >> /etc/init/smbd.override
echo manual >> /etc/init/nmbd.override
mv /etc/inetd.conf /etc/inetd.disabled
update-rc.d tor disable
# turn off samba
echo manual >> /etc/init/winbind.override

# turn off new DAVIX installed services
# turn off snort
update-rc.d snort disable
# turn off pads
update-rc.d pads disable
# turn off prads
update-rc.d prads disable
# turn off avahi-daemon discovery 
update-rc.d avahi-daemon disable
# turn off logstash
echo manual >> /etc/init/logstash.override
# turn off mrtg
sed -i -e 's/^/#/' /etc/cron.d/mrtg
# turn off ntop
sed -i -e 's/ENABLED=1/ENABLED=0/' /etc/default/ntop
update-rc.d ntop disable
# turn off sagan
update-rc.d sagan disable

# fixing some permissions
echo "session required pam_systemd.so" >> /etc/pam.d/lxdm 

# some other cleanup
apt-get -y remove cups-common xmms2-core
apt-get -y autoremove

# just to be sure!
chown -R davix:davix /home/davix
chmod -R 777 /etc/snort      # for convenience
