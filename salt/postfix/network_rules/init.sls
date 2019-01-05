'firewall-cmd --zone=public --permanent --add-service=http':
    cmd.run

'firewall-cmd --zone=public --permanent --add-service=https':
    cmd.run

'firewall-cmd --zone=public --permanent --add-service=smtp':
    cmd.run

'firewall-cmd --zone=public --permanent --add-service=smtps':
    cmd.run

'firewall-cmd --zone=public --permanent --add-service=pop3':
    cmd.run

'firewall-cmd --zone=public --permanent --add-service=pop3s':
    cmd.run

'firewall-cmd --reload':
    cmd.run

'setsebool -P httpd_can_network_connect on':
    cmd.run

'iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT':
    cmd.run

'iptables -A INPUT -m state --state NEW -m udp -p udp --dport 25 -j ACCEPT':
    cmd.run