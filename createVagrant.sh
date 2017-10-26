#!/bin/bash

# This is an ugly hack that blocks the user from typing in incorrect inputs
# It is actually used a couple of times in this script, while not using complex conditional statements, which are ugly in Bash

flag="1"
while [ $flag -eq "1" ]
    do
    flag="0"
    echo 'How will we name the directory we create the VM into? (leave empty for newVagrant)'
    read dirName
    # Check if empty and fills in default if needed
    if [ -z "$dirName" ]; then
        dirName='newVagrant'
    fi

    # Check if dirName si an existing directory (BAD)
    if [ -d "$dirName" ]; then
        echo 'This directory already exists'
        echo ''
        flag="1"
    fi
done


echo ' '
echo 'What box will we use? (leave empty for ubuntu xenial 64bits)'
read inputedBox
if [ -z "$inputedBox" ]; then
    inputedBox='ubuntu/xenial64'
fi

echo ' '
echo 'What ip shall we use? (leave empty for 192.168.33.10)'
read inputedIp
if [ -z "$inputedIp" ]; then
    inputedIp='192.168.33.10'
fi


mkdir $dirName
cd $dirName

touch Vagrantfile

# Manually creating the Vagrantfile

echo '# -*- mode: ruby -*-' >> Vagrantfile
echo '# vi: set ft=ruby :' >> Vagrantfile

echo 'Vagrant.configure("2") do |config|' >> Vagrantfile

echo "config.vm.box = '$inputedBox'" >> Vagrantfile

echo "config.vm.network 'private_network', ip: '$inputedIp'" >> Vagrantfile

echo ' '
echo 'Should we mount a shared folder? (Y/n)'
read input
if [ -z "$input" ]; then
    input='y'
fi



if [ $input = "y" -o $input = "Y" ]; then

    flag="1"

    while [ $flag -eq "1" ]
        do
        flag="0"

        echo ' '
        echo 'Local directory name? (leave empty for data)'
        read inputedLocal
        if [ -z "$inputedLocal" ]; then
          inputedLocal='data'
        fi

    # Check if the inputedLocal is a valid name. (BAD)
        mkdir "$inputedLocal" || flag=1



        echo ' '
        echo 'Distant absolute path to the shared folder? (leave empty for /var/www/html)'
        read inputedDistant
        if [ -z "$inputedDistant" ]; then
            inputedDistant='/var/www/html'
        fi

    # Check if the inputed distant path is absolute (starts with /) (GOOD)
        if [[ ! $inputedDistant == /* ]]; then
            flag="1"
            echo "Distant path must be absolute"
        fi
    done


    echo  "config.vm.synced_folder '$inputedLocal', '$inputedDistant'" >> Vagrantfile
fi

echo "Configuration done, please wait a couple of minutes"


echo 'config.vm.provider "virtualbox" do |vb|' >> Vagrantfile
echo '  vb.memory = "1024"' >> Vagrantfile
echo "end" >> Vagrantfile

echo 'end' >> Vagrantfile

vagrant up
vagrant ssh
