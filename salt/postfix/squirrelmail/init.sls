squirrelmail:
    pkg.installed

/usr/share/squirrelmail/config/config.php:
    file.managed:
        - source: salt://squirrelmail/config_files/config.php

/etc/httpd/conf/httpd.conf:
    file.managed:
        - source: salt://squirrelmail/config_files/httpd.conf

'systemctl restart httpd':
    cmd.run
    
'systemctl enable httpd':
    cmd.run
