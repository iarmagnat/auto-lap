#!/bin/bash

# This file is the exact same as createVagrant.sh, with the addition af a provider file in the Vagrantfile
# This provider then installs Apache2 and php7 inside the VM

flag="1"
while [ $flag -eq "1" ]
do
    flag="0"
    echo 'How will we name the directory we create the VM into? (leave empty for newVagrant)'
    read dirName
    if [ -z "$dirName" ]; then
        dirName='newVagrant'
    fi

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

        mkdir "$inputedLocal" || flag=1



        echo ' '
        echo 'Distant absolute path to the shared folder? (leave empty for /var/www/html)'
        read inputedDistant
        if [ -z "$inputedDistant" ]; then
            inputedDistant='/var/www/html'
        fi

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

# provisioning: execute the install script (setup.sh) inside the vagrant
echo 'config.vm.provision "shell" do |s|' >> Vagrantfile
echo 's.path = "../setup.sh" ' >> Vagrantfile
echo 'end' >> Vagrantfile

echo 'end' >> Vagrantfile

vagrant up
vagrant ssh
