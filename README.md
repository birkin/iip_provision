# iip vagrant provision script

( UNDER DEVELOPMENT )

##What this does

This code uses [Vagrant](http://www.vagrantup.com/) to configure a working environment to run Brown's [Django](http://djangoproject.org) app for the [Inscriptions of Israel/Palestine](http://library.brown.edu/cds/projects/iip/) project.

Specifically, it will

- use [VirtualBox](https://www.virtualbox.org/) to install an Ubuntu '64 Precise' image
- install all necessary software on the Ubuntu server
- create a virtual environment on the server that runs Python 2.6 (to match the Library's server configuration)
- install the current github code for the iip project

The install of all the software will take several minutes. Suggestion: use ethernet and enjoy a cup of coffee.

##Requirements

The following must already be installed on your computer

- [git](http://git-scm.com)
- [Vagrant](http://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

These are all open source software packages.

To follow these instructions you don't need to know anything about them, but you might want to spend some time with the [Vagrant Documentation](http://docs.vagrantup.com/v2/), especially the Getting Started Tutorial, which is very good.

##Install

####Grab the provisioning code

    laptop$ git clone https://github.com/brown-university-library/iip_provision.git ./iip_provision

This creates a directory, 'iip_provision'.

####Update the settings.

Add a file named 'iip_private_settings.sh' at iip_provision/resources/iip_private_settings.sh

You'll see a sample file there that you can update and rename, or just add your own.

####Create and provision the Vagrant Box

    laptop$ cd ./iip_provision
    laptop$ vagrant up

After running 'vagrant up', you'll see lots of text scrolling by. At points the install may _seem_ hung up, but it's not. Also, some of the output may look like error messages; don't worry, this is normal.

For subsequent vagrant startups, you can use the --no-provision flag (laptop$ vagrant up --no-provision) to just start the server without the full install script running.

That's it for the install.

##Usage

####Login to the Vagrant Box

(Assuming you're still in the 'iip_provision' directory)

    laptop$ vagrant ssh

 optional...

    vagrant$ pwd
    /home/vagrant

####Activate the python virtual environment

    vagrant$ source ./env_iip/bin/activate

Your prompt should now be [env-iip].

####Move to the iip_project directory

    [env-iip]vagrant$ cd ./iip_project/

##Start the built-in django web-server

If you're off-campus, run VPN to minimize the chance of things not working. Then...

    [env-iip]vagrant$ python ./manage.py runserver 0.0.0.0:8000

The output you'll see is:

    Validating models...

    0 errors found
    Django version 1.4.1-, using settings 'iip.settings'
    Development server is running at http://0.0.0.0:8000/
    Quit the server with CONTROL-C.

Open a browser window back on your home computer and point it to <http://127.0.0.1:6789/search/>

(Why port 6789 when the dev-server was started with port 8000? Because the iip_provision/Vagrantfile file tells vagrant to listen on your laptop for incoming laptop port 6789 requests, and route them to your Ubuntu box's port 8000.)

You should be looking at the main iip search page.

## Notes
 * This is intended for development only.
 * The source at `/home/vagrant/iip_project` is cloned from a separate github repository.
 * Your Django environment will be dropped and reconfigured anytime that `vagrant reload` or `vagrant provision` is run.  Be sure to backup any data or code before running these commands.

## Acknowledgements
Thanks to [Jean Bauer](https://github.com/jabauer) for django provisioning advocacy and code.
