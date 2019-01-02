sudo curl https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/jenkins_conf -o /etc/default/jenkins
sudo curl https://raw.githubusercontent.com/florian-vuillemot/Plan-B/master/azure/jenkins/nginx_conf -o /etc/nginx/sites-enabled/default

sudo cp /home/epitech/certificate.crt /etc/ssl/certs/nginx-selfsigned.crt
sudo cp /home/epitech/certificate.key /etc/ssl/private/nginx-selfsigned.key

sudo service jenkins restart
sudo service nginx restart
