KEY=/tmp/id_rsa.pub
hostnamectl set-hostname $1
mkdir -p /root/.ssh
cat $KEY >> /root/.ssh/authorized_keys

#sudo firewall-cmd --permanent --zone=public --add-service=http
#sudo firewall-cmd --permanent --zone=public --add-service=https
#sudo firewall-cmd --add-port=8080/tcp --permanent
#sudo firewall-cmd --add-port=6443/tcp --permanent
#sudo firewall-cmd --add-port=30090/tcp --permanent
#sudo firewall-cmd --reload

sudo systemctl stop firewalld
sudo systemctl disable firewalld
