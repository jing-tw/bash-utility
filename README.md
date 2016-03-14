# bash-utility

### Setup Proxy
1. Local Host Proxy Setup
    - source proxy_utility.sh
    - all_proxy   # enable proxy
    - no_proxy  # disable proxy
2. Remote Host Proxy Setup
    - ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);all_proxy"   # Enable proxy to the remothe host
    - ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);no_proxy"   # Disable proxy to the remothe host

## Setup Hostname
1. Local Change Hostname
    - source name_utility.sh
    - change_hostname abc
2. Remote Change Hostname
    - ssh -t ubuntu@10.109.62.118 "$(< ip_utility.sh);$(< name_utility.sh);changehostname abc"

### Puppet Maseter Ready
1. source puppet_utility.sh
2. puppet_master_ready
