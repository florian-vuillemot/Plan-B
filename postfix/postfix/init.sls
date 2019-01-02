sendmail:
    pkg.removed


/etc/hosts:
    file.managed:
        - source: salt://postfix/config_files/hosts

epel-release:
      pkg.installed