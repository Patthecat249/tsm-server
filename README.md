# Installation of a ISP-Server aka TSM-Server
This repo contains the installation of a IBM Spectrum Protect-Server.
## Guide
### Prepare a kickstart.cfg-Configuration file for automated Installation

```bash
# login to terraform-host
mypath=$(pwd)
cd $mypath/git/pxe-server/playbooks/ && ansible-playbook 10_create_vm.yaml

# Enter the Name of the "tsm"-Server
```

*Proceed with next Step "Create a VM in vCenter"*



## Start PXE-Installation of the TSM-Server

- Start VM in vCenter
- Open web-console of VM
- Choose **number 4: "Install RHEL77"**
- wait for successful installation 



## Login to TSM-Server and Disable SELinux

```bash
# ssh tsm-server
vi /etc/selinux/config
#SELINUX=enforcing
SELINUX=disabled
:wq
reboot
```





## Requirements

- VMware 6.7 with vCenter 6.7
- NFS-Server
- RHEL77
- 8x vCPU
- 16GB RAM
- IBM-Software for the installation of the ISP-Server
- Ansible