#!/bin/sh
# This script copies public key to authorized_key file of root
# Assumes that this script is called with 'sudo'
# Parameter: hostname

MUSER=mosipuser
HOME=/home/$MUSER
KEY=id_rsa
hostnamectl set-hostname $1
adduser $MUSER 
chmod 755 $HOME # Needed for nginx access to display files
SSH_DIR=$HOME/.ssh
mkdir -p $SSH_DIR 
chown $MUSER $SSH_DIR 
chgrp $MUSER $SSH_DIR 
echo "$MUSER ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers
cp /tmp/$KEY* $SSH_DIR 
cat $SSH_DIR/$KEY.pub >> $SSH_DIR/authorized_keys
chmod 600 $SSH_DIR/$KEY
chown $MUSER $SSH_DIR/*
chgrp $MUSER $SSH_DIR/*




#sudo firewall-cmd --permanent --zone=public --add-service=http
#sudo firewall-cmd --permanent --zone=public --add-service=https
#sudo firewall-cmd --add-port=8080/tcp --permanent
#sudo firewall-cmd --add-port=6443/tcp --permanent
#sudo firewall-cmd --add-port=30090/tcp --permanent
#sudo firewall-cmd --add-port=30616/tcp --permanent
#sudo firewall-cmd --add-port=53/tcp --permanent

#sudo firewall-cmd --reload

sudo systemctl stop firewalld
sudo systemctl disable firewalld





# Mount Block volume.
# CAUTION: the partition name is hardcoded. It may change.
sudo mkfs -t xfs /dev/sdb
sudo mount /dev/sdb /srv
# Make the above permanent
#echo "/dev/sdb /srv                       xfs     defaults        0 0" >> /etc/fstab
echo "/dev/sdb /srv                       xfs     defaults        0 0" sudo tee -a  /etc/fstab 
#cd /srv/
#sudo mkdir nfs
#cd nfs/
#sudo mkdir mosip


