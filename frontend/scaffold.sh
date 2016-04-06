#!/bin/bash

set -ue

source config.sh
cd $(dirname $0)

function Camelize() {
    IFS='_' read -a snake_str
    for c in ${snake_str[*]}; do
        echo -n ${c^}
    done
}

function scaffold_pages() {
    CONTAINERS=$(join_path $JAVASCRIPTS_DIR "containers")

    for ACTION in $(bundle exec rake routes \
                            | sed -e "1d" -e "s,^[^/]*,,g" \
                            | awk '{print $2}' \
                            | grep 'api/' \
                            | sed -e 's|api/v1/||g' \
                            | grep -v '#update' \
                            | grep -v '#create' \
                            | grep -v '#destroy'); do

        SNAKE_CASE=$(echo $ACTION | sed -e 's|#|_|')
        JS_FILE=$(join_path $CONTAINERS ${SNAKE_CASE}.js)
        CLASS_NAME=$(basename $SNAKE_CASE | Camelize)

        mkdir -p $(dirname $JS_FILE)

        if [ ! -f $JS_FILE ]; then
            cat template_page.js \
                | sed -e "s|\$CLASS_NAME|$CLASS_NAME|g" \
                | sed -e "s|\$JS_FILE|$JS_FILE|g" \
                | sed -e "s|\$ACTION|$ACTION|g" \
                      > $JS_FILE
        fi
    done

    `npm bin`/create-index $CONTAINERS
}

scaffold_pages
