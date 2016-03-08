g_http_proxy=http://10.110.15.60:8080
g_https_proxy=https://10.110.15.60:8080

# Usage:
# . ./proxy_utility.sh
# all_proxy
# Test:
#   apt-get update
#   wget http://www.kimo.com.tw
function all_proxy(){
    apt_proxy
    wget_proxy
    git_proxy
}

# Usage:
#  . ./proxy_utility.sh
#  no_proxy
# Test:
#  apt-get update
function no_proxy(){
    apt_noproxy
    wget_noproxy
    git_noproxy
}

# Usage:
#  . ./proxy_utility.sh
#  apt_proxy
# Test
#  apt-get update
function apt_proxy(){
    local file=/etc/apt/apt.conf.d/01proxy
    echo "Acquire::http::Proxy \"http://10.110.15.60:8080\";" | sudo tee -a ${file}
    echo "Acquire::https::Proxy \"https://10.110.15.60:8080\";" | sudo tee -a ${file}
}

function apt_noproxy(){
    local file=/etc/apt/apt.conf.d/01proxy
    if [ -f ${file} ]
    then
       sudo rm ${file}
    else
       echo "apt_noproxy: apt_proxy had been removed!"
    fi
}

# Usage:
# wget_proxy
# Test:
#  wget http://www.kimo.com.tw
function wget_proxy(){
    local file=/etc/wgetrc
    # uncomment user_proxy
    sudo sed -i '/use_proxy/s/^#//g' ${file}
    sudo sed -i 's#^.*\bhttp_proxy\b.*$#http_proxy=http://10.110.15.60:8080#g' ${file}
    sudo sed -i 's#^.*\bhttps_proxy\b.*$#https_proxy=https://10.110.15.60:8080#g' ${file}
}

function wget_noproxy(){
    local file=/etc/wgetrc
    sudo sed -i '/use_proxy/s/^/#/g' ${file}
    sudo sed -i '/http_proxy/s/^/#/g' ${file}   
    sudo sed -i '/https_proxy/s/^/#/g' ${file}
}

function git_proxy(){
    git config --global http.proxy ${g_http_proxy}
    git config --global https.proxy ${g_https_proxy}

    git_status
}

function git_noproxy(){
    git config --global --unset http.proxy
    git config --global --unset https.proxy
 
    git_status
}

function git_status(){
    git config --global --get http.proxy
    git config --global --get https.proxy
}
