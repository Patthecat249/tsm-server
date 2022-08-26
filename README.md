# Installation of a ISP-Server aka TSM-Server
This repo contains the installation of a IBM Spectrum Protect-Server.
## Guide

### Download Repo-PXE-Server
# ssh into install-vm
```bash
mypath=$(pwd)
mkdir git && cd git
git clone https://github.com/Patthecat249/pxe-server.git
```

### Prepare a kickstart.cfg-Configuration file for automated Installation

```bash
# login to terraform-host
mypath=$(pwd)
cd $mypath/git/pxe-server/playbooks/ && ansible-playbook 10_create_vm.yaml
# or try this
cd $mypath/git/pxe-server/playbooks && ansible-playbook 11_create_vm_from_clone.yaml -e "hostname=tsm-server cpu=8 ram=16384"

# Enter the Name of the "tsm"-Server
```

*Proceed with next Step "Create a VM in vCenter"*



### Start PXE-Installation of the TSM-Server

- Start VM in vCenter
- Open web-console of VM
- Choose **number 4: "Install RHEL77"**
- wait for successful installation 



### Login to TSM-Server and Disable SELinux

```bash
# ssh root@tsm-server
vi /etc/selinux/config
#SELINUX=enforcing
SELINUX=disabled
:wq
reboot
```



## Start TSM-Server Software installation/configuration-Playbook

```bash
ssh root@terraform
mypath=$(pwd)
cd $mypath/git/tsm-server/ansible/ && ansible-playbook playbooks/10_install_configure_a_tsm_server.yaml -k

# This step need about 1 hour.
```



## Configure TSM specifics



### Prepare Disk in Linux for Backups



### Configure TSM:  Storage-Pools, Device-Class, Nodes

```bash
# 
dsmadmc 
```





## Requirements

- VMware 6.7 with vCenter 6.7
- NFS-Server
- RHEL77
- 8x vCPU
- 16GB RAM
- IBM-Software for the installation of the ISP-Server
- Ansible
