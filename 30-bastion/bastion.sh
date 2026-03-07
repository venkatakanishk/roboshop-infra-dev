#! /bin/bash


# we are creating 50G root volume, but only 20G is partionied
#Remanining 30G we need to extend using below commands

growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home


#install Terraform


yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform