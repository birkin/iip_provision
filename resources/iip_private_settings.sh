#!/bin/bash


## Settings for iip_project which are install-specific or, in production, private.
##
## This file is accessed by iip_stuff/env_iip/bin/activate when using django's 'runserver'.
## Though the iip_project code is completely apache-wsgi compatible, these settings assume django's 'runserver'.
## This file must reside in this 'resources' directory and be named 'iip_private_settings.sh'


## iip project settings

export IIP_ALLOWED_HOSTS='["127.0.0.1"]'  # json

export IIP_DATABASES_ENGINE="django.db.backends.sqlite3"
export IIP_DATABASES_NAME="/resources/iip.db"

export IIP_DEBUG="True"  # "" (not "False") on production, fyi (it's checked)

export IIP_SECRET_KEY="i_will_never_tell"

export IIP_STATIC_ROOT=""  # assumes django 'runserver', not apache wsgi
export IIP_STATIC_URL="/static/"  # assumes django 'runserver', not apache wsgi


## iip_search_app settings

export IIP_SEARCH__LOG_PATH="/home/vagrant/iip_project/logs/iip_search_app.log"

export IIP_SEARCH__SOLR_URL=""  # fill in manually for now; eventually will be public
export IIP_SEARCH__BIBSOLR_URL=""  # fill in manually for now; eventually will be replaced by zotero call


## end
