sendmail:
    pkg.removed


/etc/hosts:
    file.managed:
        - source: salt://postfix/config_files/hosts

epel-release:
      pkg.installed

postfix:
    pkg.installed

/etc/postfix/main.cf:
    file.managed:
        - source: salt://postfix/config_files/main.cf

'systemctl restart postfix':
    cmd.run

'systemctl enable postfix':
    cmd.run

