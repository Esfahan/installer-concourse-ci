# Installer for Concourse CI
This is a installer to use Concourse CI on CentOS7.x.

- docker 17.05.0-ce
- docker-compose version 1.15.0
- docker-compose.yml for Concourse CI

## Notice
Concourse CI needs kernel v3.19 or later.  
Check your version with `uname -r`.  
If you need to update kernel, follow the steps below.


## How to update kernel
### add ELRepo

```
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
```

### enable elrepo-kernel

```
sudo cp files/elrepo.repo /etc/yum.repos.d/elrepo.repo
```

### remove current kernels

```
rpm -qa kernel\* | sort > /tmp/kernels

while read line ; do
  sudo yum -y remove ${line}
done < /tmp/kernels
```

### re:install

```
sudo yum -y update
sudo yum -y install kernel-ml.x86_64 \
kernel-ml-devel.x86_64 \
kernel-ml-headers.x86_64 \
kernel-ml-tools.x86_64 \
kernel-ml-tools-libs.x86_64
```

### set default Kernel to boot

```
sudo grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

### reboot

```
sudo reboot
```

### remove the old kernels

```
sudo yum remove kernel
```

### check the current version

```
rpm -qa kernel\* | sort
```
