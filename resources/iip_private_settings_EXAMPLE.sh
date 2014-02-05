#!/bin/bash

##
## Sample file of settings which are install-specific or private.
##
## THE ACTUAL FILE MUST RESIDE IN THIS RESOURCES DIRECTORY AND BE NAMED 'iip_private_settings.sh'
##
## The django project settings at 'iip_project/iip_config/settings.py' reference values created here.
## The django iip_search_app settings at 'iip_project/iip_search_app/settings_app.py' reference values created here.
##


## iip_project settings ##

export IIP_SECRET_KEY="i_will_never_tell"  # fine as is for vagrant install

export IIP_DATABASES_ENGINE="django.db.backends.sqlite3"  # fine as is for vagrant install
export IIP_DATABASES_NAME="/resources/iip.db"  # fine as is for vagrant install


## iip_search_app settings ##

export IIP_SEARCH__LOG_PATH="/home/vagrant/iip_project/logs/iip_search_app.log"  # fine as is for vagrant install

export IIP_SEARCH__SOLR_URL="ADD_HERE"  # eventually will be a public url
