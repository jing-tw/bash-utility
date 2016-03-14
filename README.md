# bash-utility

### Setup Proxy
1. Local Host Proxy Setup
    - source proxy_utility.sh
    - all_proxy   # enable proxy
    - no_proxy  # disable proxy
2. Remote Host Proxy Setup
    - ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);all_proxy"   # Enable proxy to the remothe host
    - ssh -t ubuntu@10.109.62.118 "$(< proxy_utility.sh);no_proxy"   # Disable proxy to the remothe host

### Puppet Maseter Ready
1. source puppet_utility.sh
2. puppet_master_ready
