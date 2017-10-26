#!/usr/bin/env bash

menu () {
    echo ' '
    echo ' '
    echo "What do you want to do?"
    echo "1 : Install Virtualbox and Vagrant (Requiered for every other actions)"
    echo "2 : Install Vagrant only (choose only if you have already installed VirtualBox)"
    echo "3 : Show installed Vagrants status and interact with them"
    echo "4 : Create a Vagrant (this will log you in the VM with ssh)"
    echo "5 : Create a Vagrant and install apache2 and Php on it (this will log you in the VM with ssh)"
    echo "6 : Exit"
}

menuCreated () {
    echo ' '
    echo ' '
    echo "What do you want to do?"
    echo "1 : turn it off"
    echo "2 : turn it on"
    echo "3 : turn it on and ssh into it"
    echo "4 : destroy it"
    echo "5 : Exit"
}

clear
echo ' '
echo -e '  ──────▄▀▀▀▀▀▀▀▄───────
  ─────▐─▄█▀▀▀█▄─▌──────
  ─────▐─▀█▄▄▄█▀─▌──────
  ──────▀▄▄▄▄▄▄▄▀───────
  ─────▐▀▄▄▐█▌▄▄▀▌──────
  ──────▀▄▄███▄▄▀───────
  █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
  █░░╦─╦╔╗╦─╔╗╔╗╔╦╗╔╗░░█
  █░░║║║╠─║─║─║║║║║╠─░░█
  █░░╚╩╝╚╝╚╝╚╝╚╝╩─╩╚╝░░█
  █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
'

menu
while read menuInput; do
    case $menuInput in
    # Quiet installs. If already installed, it will simply pass.
        1)
        echo "Installing VirtualBox"
        sudo apt-get install -qq virtualbox-5.1 -y

        echo "Installing vagrant"
        sudo apt-get install -qq vagrant -y;;

        2)
        echo "Installing vagrant"
        sudo apt-get install -qq vagrant -y;;

        3)
        echo ''
        echo ''


    # here I process the result of vagrant global-status
    # I used a temp file in order to keep clarity, and then remove it
        vagrant global-status >> tmp-script
        sed -i '/The/d' ./tmp-script
        sed -i '/on/d' ./tmp-script
        sed -i '/up-to-date./d' ./tmp-script
        sed -i '/that/d' ./tmp-script
        sed -i '/with/d' ./tmp-script
        sed -i '/"vagrant/d' ./tmp-script
        echo "Current vagrants status "
        cat tmp
        rm ./tmp


        echo "Copy/paste in the id of the Vagrant you want to interact with. (Leave empty to quit)"
        read vagrantID
        if [ ! -z "$vagrantID" ]; then
            menuCreated
            read menuCreatedInput
            case $menuCreatedInput in
                1)
                vagrant halt $vagrantID
                ;;

                2)
                vagrant up $vagrantID
                ;;

                3)
                vagrant up $vagrantID
                vagrant ssh $vagrantID
                ;;

                4)
                vagrant destroy $vagrantID
                ;;

                *)
                ;;
            esac
        fi
        break;;

    # If the user choses it, the script sources the createVagrant or createVagrantApache scripts in order to create vagrants
        4)
        echo ''
        echo ''
        source ./createVagrant.sh
        break;;

        5)
        echo ''
        echo ''
        source ./createVagrantApache.sh
        break;;

        *)
        break;;

    esac
    menu
done