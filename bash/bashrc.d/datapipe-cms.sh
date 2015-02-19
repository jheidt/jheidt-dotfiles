#!/bin/bash

alias cdcms='pushd ~/Projects/cloud-management-system/'

function cms_start()
{
    sudo systemctl start mysqld
    sudo systemctl start memcached
    sudo systemctl start redis
}

function cms_stop()
{
    sudo systemctl stop mysqld
    sudo systemctl stop memcached
    sudo systemctl stop redis
}