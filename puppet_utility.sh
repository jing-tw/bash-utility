#!/bin/bash

# Load name_utility
. ./name_utility.sh

# Global variable
gPUPPET_MASTER_NAME=puppet-master.openstacklocal
gPUPPET_MASTER_IP=10.109.62.118


# Function: puppet_master_ready, setup puppet master environment
#
function puppet_master_ready(){
    changehostname ${gPUPPET_MASTER_NAME}
    addhost ${gPUPPET_MASTER_NAME} ${gPUPPET_MASTER_IP}
    puppet_master_install       
    puppet_master_test
}   

function puppet_master_test(){
    ping ${gPUPPET_MASTER_NAME} -c 10
}

function puppet_master_install(){
    cd /tmp
    wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
    sudo dpkg -i puppetlabs-release-trusty.deb
    sudo apt-get update
    sudo apt-get --yes --force-yes install puppetmaster
}
