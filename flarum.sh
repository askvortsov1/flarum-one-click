#!/bin/bash

OVERRIDE_PATHS=("site.php" "index.php" "flarum" "assets" "storage" ".htaccess" ".nginx.conf")
NON_OVERRIDE_PATHS=("config.php" "composer.json" "extend.php")

interactive=1


mk_tmp_dir()
{
    mkdir .tmp
}

rm_tmp_dir()
{
    rm -rf .tmp
}

download()
{
    curl -o .tmp/flarum.zip --remote-name --location https://github.com/askvortsov1/flarum-one-click/releases/latest/download/release.zip
    unzip .tmp/flarum.zip -d .tmp/flarum
}

compat()
{
    if [ -f "public/assets" ]; then
        mv public/assets assets
    fi
    if [ -f "bootstrap.php" ]; then
        mv bootstrap.php extend.php
    fi
    rm -rf public
}

install()
{
    for t in ${OVERRIDE_PATHS[@]}; do
        mv -f ".tmp/flarum/$t" .
    done
    for t in ${NON_OVERRIDE_PATHS[@]}; do
        if [ ! -f "$t" ]; then
            mv ".tmp/flarum/$t" .
        fi
    done
}


# MAIN

mk_tmp_dir
download
compat
install
rm_tmp_dir

