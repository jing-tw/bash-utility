#!/bin/sh

# Library
. ./ip_utility.sh

# PATH TO YOUR HOSTS FILE
ETC_HOSTS=/etc/hosts


# Function: removehost
# Usage:
#   removehost vm4
# Return:
#   0: success
#   1: fail
function removehost() {
    local HOSTNAME=$1
    if [ -z "$HOSTNAME" ]; then
        echo "Usage: removehost HOSTNAME"
        return 1
    fi

    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
    then
        echo "$HOSTNAME Found in your $ETC_HOSTS, Removing now...";
        sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS
        return 0
    else
        echo "$HOSTNAME was not found in your $ETC_HOSTS";
        return 1 
    fi
}

# Function: addhost
# Usage:
#   addhost vm4 10.109.62.233
# Return:
#   0: success
#   1: fail
function addhost() {
    HOSTNAME=$1
    IP=$2
   
    valid_ip ${IP}
   
    if [[ $? -eq 1 ]]
    then 
        echo "Usage: addhost hostname ip"
        return 1
    fi

    HOSTS_LINE="$IP\t$HOSTNAME"
    if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
        then
            echo "$HOSTNAME already exists : $(grep $HOSTNAME $ETC_HOSTS)"
        else
            echo "Adding $HOSTNAME to your $ETC_HOSTS";
            sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";

            if [ -n "$(grep $HOSTNAME /etc/hosts)" ]
                then
                    echo "$HOSTNAME was added succesfully \n $(grep $HOSTNAME /etc/hosts)";
                else
                    echo "Failed to Add $HOSTNAME, Try again!";
            fi
    fi
}
