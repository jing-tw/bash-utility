# bash-utility

### Setup Proxy
* Local Host Proxy Setup
``` bash
source proxy_utility.sh
all_proxy   # enable proxy
no_proxy  # disable proxy
```
* Remote Host Proxy Setup
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);all_proxy"   # Enable proxy to the remothe host
ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);no_proxy"   # Disable proxy to the remothe host
```
## Setup Hostname
* Local Change Hostname
``` bash   
source name_utility.sh; source ip_utility.sh
change_hostname abc
```
* Remote Change Hostname
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< ip_utility.sh);$(< name_utility.sh);change_hostname abc"
``` 

## Name Resolving (/etc/hosts)
* Local Add Host
``` bash
 source name_utility.sh; source ip_utility.sh
 add_host vm 192.168.62.183
```
* Remote Add Host
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< ip_utility.sh);$(< name_utility.sh);add_host vm1 192.168.62.183"
```

* Remote Add Host (Array)
``` bash
source name_utility.sh; source ip_utility.sh
HostNameArray=(vm1 vm2 vm3)
IPArray=("10.109.62.118" "10.109.62.124" "10.109.62.138")

add_host_array $HostNameArray $IPArray
```

### Puppet Maseter Ready
``` bash
    source puppet_utility.sh
    puppet_master_ready
```
