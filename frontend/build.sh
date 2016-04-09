#!/usr/bin/env bash

set -ue

source config.sh
cd $(dirname $0)

while getopts wsp:h OPT
do
    case $OPT in
        w)  WATCH=yes
            ;;
        h | \?)
            echo "Usage: $0 [-w]" 1>&2
            exit 1
            ;;
    esac
done

PIDS=()
function cleanup() {
    echo
    echo "exiting..."
    for (( I = 0; I < ${#PIDS[@]}; ++I ))
    do
        kill ${PIDS[$I]}
    done
}

function register() {
    PIDS=("${PIDS[@]:+${PIDS[@]}}" "${1}")
}

trap cleanup 2

function build_javascripts() {
    mkdir -p $(join_path ${DESTINATION_DIR} ${JAVASCRIPTS_DIR})
    local OPTS="$BROWSERIFY_OPTS \
          $(join_path ${SOURCE_DIR} ${JAVASCRIPTS_DIR} ${JS_ENTRY_FILE}) \
          -o $(join_path ${DESTINATION_DIR} ${JAVASCRIPTS_DIR} ${JS_BUNDLED_FILE})"

    if [ ${WATCH:-x} = "yes" ]; then
        watchify -d -v $OPTS &
        register $!
    else
        browserify $OPTS &
        register $!
    fi
}

function build_stylesheets() {
    mkdir -p $(join_path ${DESTINATION_DIR} ${STYLESHEETS_DIR})
    local OPTS="$NODE_SASS_OPTS \
          $(join_path ${SOURCE_DIR} ${STYLESHEETS_DIR} ${SASS_ENTRY_FILE}) \
          $(join_path ${DESTINATION_DIR} ${STYLESHEETS_DIR} ${CSS_BUNDLED_FILE})"

    local WATCH_OPTS=""
    if [ ${WATCH:-x} = "yes" ]; then
        WATCH_OPTS="-w"
    fi

    node-sass ${WATCH_OPTS} ${OPTS} &
    register $!
}

#-------------------------------------------------------------------------------

npm install

build_javascripts
build_stylesheets

wait
