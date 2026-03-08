#! /bin/bash

dnf install ansible -y
component=$1
cd /home/ec2-user
git clone https://github.com/venkatakanishk/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf
git pull
ansible-playbook -e component=$component roboshop.yaml