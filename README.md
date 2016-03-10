# bash-utility

### Setup Proxy
1. source proxy_utility.sh
2. all_proxy
3. Remote Setup: ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);all_proxy" 

### Remove Proxy
1. source proxy_utility.sh
2. no_proxy

### Puppet Maseter Ready
1. source puppet_utility.sh
2. puppet_master_ready
