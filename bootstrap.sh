#!/bin/bash

# This script is called directly from the Vagrantfile


## general config ##

#vagrant config?
export DEBIAN_FRONTEND=noninteractive
set -e # Exit script immediately on first error.
set -x # Print commands and their arguments as they are executed.

#update package manager resources
sudo apt-get update -y

#set time zone
area="America"
zone="New_York"
sudo echo "$area/$zone" > /tmp/timezone
sudo cp -f /tmp/timezone /etc/timezone
sudo cp -f /usr/share/zoneinfo/$area/$zone /etc/localtime

## end general config ##


## main server installs ##

#basics
sudo apt-get install -y git-core
# sudo apt-get install -y git-core mercurial vim screen wget curl raptor-utils unzip
# sudo apt-get install -y tree

#apache
# sudo apt-get install -y apache2

#System Python (2.7) (bdj- needed?)
sudo apt-get install -y python python-dev python-mysqldb python-lxml python-virtualenv
sudo apt-get install -y libmysqlclient-dev

sudo apt-get install -y python-software-properties #required for add-apt-repository command below
sudo apt-get update -y

#Python 2.6 for use in Virtual Environment (to match production server)
#This repository can be found here https://launchpad.net/~fkrull/+archive/deadsnakes
sudo add-apt-repository -y ppa:fkrull/deadsnakes
sudo apt-get update -y
sudo apt-get install -y python2.6 python2.6-dev

# #MySQL
# echo mysql-server mysql-server/root_password password vagrant | sudo debconf-set-selections
# echo mysql-server mysql-server/root_password_again password vagrant | sudo debconf-set-selections
# sudo apt-get install -y mysql-server
# sudo apt-get install -y mysql-client

#lxml dependencies -- loaded later from requirements.txt
apt-get -y install libxml2-dev libxslt-dev

## end main server installs ##


## grab iip code ##

#ensure iip_project is empty before the clone
find ./iip_project -mindepth 1 -delete

#grab the project
git clone https://github.com/Brown-University-Library/iip.git iip_project

## end grab iip code ##


## virtualenv work ##

#Create a virtualenv and ACTIVATE it
virtualenv -p python2.6 --prompt=[env_iip] /home/vagrant/env_iip
source /home/vagrant/env_iip/bin/activate

#install necessary python packages
pip install -r /home/vagrant/iip_project/iip_config/requirements.txt

## end virtualenv work ##


## create support files ##

#logs
mkdir /home/vagrant/iip_project/logs
touch /home/vagrant/iip_project/logs/iip_search_app.log
sudo chmod 777 /home/vagrant/iip_project/logs/iip_search_app.log

## end create support files ##


## connect private settings to virtual environment ##

#update the virtual environment's activate script
#the bottom of the new script sources the project.sh and app.sh files
# cp /resources/activate /home/vagrant/iip_project/env_iip/bin/activate
echo " " >> /home/vagrant/env_iip/bin/activate
echo " " >> /home/vagrant/env_iip/bin/activate
echo "## load iip private settings into environment ##" >> /home/vagrant/env_iip/bin/activate
echo "source \"/resources/iip_private_settings.sh\"" >> /home/vagrant/env_iip/bin/activate

#reactivate the virtual environment
source /home/vagrant/env_iip/bin/activate

## end connect private settings to virtual environment ##


echo "---"
echo "Box provisioned!"
echo "Now log into vagrant, intialize the virtual environment, start the dev server and you'll be able to access the iip project!"
echo "---"


exit
