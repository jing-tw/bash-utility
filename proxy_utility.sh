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
    echo "Acquire::http::Proxy \"${g_http_proxy}\";" | sudo tee -a ${file}
    echo "Acquire::https::Proxy \"${g_https_proxy}\";" | sudo tee -a ${file}

    echo "apt_proxy:: apt proxy has been enabled."
}

function apt_noproxy(){
    local file=/etc/apt/apt.conf.d/01proxy
    if [ -f ${file} ]
    then
       sudo rm ${file}
       echo "apt_noproxy: apt_proxy has been disabled."
    else
       echo "apt_noproxy: apt_proxy had been removed!"
    fi
}

# Usage:
# wget_proxy
# Test:
#  wget http://www.kimo.com.tw
function wget_proxy(){
    #local file=/etc/wgetrc
    local file=~/.wgetrc

    # check if the file exist
    if [ -f ${file} ]
    then
       echo "Found ${file}"
    else
       echo "Create a new ${file}"
       touch ${file}
       echo "use_proxy=on" | tee -a ${file}
       echo "http_proxy=${g_http_proxy}" | tee -a ${file}
       echo "https_proxy=${g_https_proxy}" | tee -a ${file}
    fi

    wget_checkproxy
    if [ $? == 0 ]; then {
       echo "wget_proxy::wget proxy has already enabled"
       return 0
    };fi

    echo "wget_proxy::setup wget proxy"

    # uncomment user_proxy
    sudo sed -i '/use_proxy/s/^#//g' ${file}
    sudo sed -i 's#^.*\bhttp_proxy\b.*$#http_proxy=http://10.110.15.60:8080#g' ${file}
    sudo sed -i 's#^.*\bhttps_proxy\b.*$#https_proxy=https://10.110.15.60:8080#g' ${file}

    cat ${file}

    echo "wget_proxy:: wget proxy has been enabled."
}

function wget_noproxy(){
    #local file=/etc/wgetrc
    local file=~/.wgetrc

    wget_checkproxy
    if [ $? == 1 ]; then {
        echo "wget_noproxy:: wget has no proxy"
        return 0   # return normal
    };fi

    sudo sed -i '/use_proxy/s/^/#/g' ${file}
    sudo sed -i '/http_proxy/s/^/#/g' ${file}   
    sudo sed -i '/https_proxy/s/^/#/g' ${file}
 
    echo "wget_noproxy:: wget proxy has been disabled."
}

# Function wget_checkproxy
# return
#  0: proxy enabled
#  1: proxy disabled
function wget_checkproxy(){
    file=~/.wgetrc

    x=`cat ${file} | grep use_proxy=yes`
    #echo ${x}
    if [[ ${x:0:1} == '#' ]]
    then
        return 1
    else
        return 0 
    fi
}

function wget_checkproxy_test(){
    wget_checkproxy
    if [ $? == 0 ]; then {
      echo "wget proxy was enabled"
    };fi
 
    wget_checkproxy
    if [ $? == 1 ]; then {
      echo "wget proxy was disabled"
    };fi
}
    
function git_install(){
    local package=git
    sudo dpkg -l $package > /dev/null 2>&1
    if [ $? == '0' ]; then
        echo "You have git"
    else
        echo "You have no git, automatically install it"
        sudo apt-get install git
    fi
}

function git_proxy(){
    
    git config --global http.proxy ${g_http_proxy}
    git config --global https.proxy ${g_https_proxy}

    git_status

    echo "git_proxy:: git proxy has been setup."
}

function git_noproxy(){
    git config --global --unset http.proxy
    git config --global --unset https.proxy
 
    git_status

    echo "git_noproxy:: git proxy has been disabled."
}

function git_status(){
    git config --global --get http.proxy
    git config --global --get https.proxy
}
