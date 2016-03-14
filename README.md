# bash-utility

### Setup Proxy
1. Local Host Proxy Setup
``` bash
source proxy_utility.sh
all_proxy   # enable proxy
no_proxy  # disable proxy
```
2. Remote Host Proxy Setup
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);all_proxy"   # Enable proxy to the remothe host
ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);no_proxy"   # Disable proxy to the remothe host
```
## Setup Hostname
1. Local Change Hostname
``` bash   
source name_utility.sh; source ip_utility.sh
change_hostname abc
```
2. Remote Change Hostname
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< ip_utility.sh);$(< name_utility.sh);change_hostname abc"
``` 

## Name Resolving (/etc/hosts)
1. Local Add Host
``` bash
 source ip_utility.sh
 add_host vm 192.168.62.183
```
2. Remote Add Host
``` bash    
ssh -t ubuntu@10.109.62.118 "$(< ip_utility.sh);$(< name_utility.sh);add_host vm 192.168.62.183"
```

### Puppet Maseter Ready
``` bash
    source puppet_utility.sh
    puppet_master_ready
```
