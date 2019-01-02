dovecot:
      pkg.installed

/etc/dovecot/dovecot.conf:
    file.managed:
        - source: salt://dovecot/config_files/dovecot.conf

/etc/dovecot/conf.d/10-mail.conf:
    file.managed:
        - source: salt://dovecot/config_files/10-mail.conf

/etc/dovecot/conf.d/10-master.conf:
    file.managed:
        - source: salt://dovecot/config_files/10-master.conf

/etc/dovecot/conf.d/10-auth.conf:
    file.managed:
        - source: salt://dovecot/config_files/10-auth.conf

'systemctl restart dovecot':
    cmd.run
 
'systemctl enable dovecot':
    cmd.run
