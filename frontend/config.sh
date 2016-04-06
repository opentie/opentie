SOURCE_DIR="."
DESTINATION_DIR="../public/assets"
JAVASCRIPTS_DIR="javascripts"
STYLESHEETS_DIR="stylesheets"

JS_ENTRY_FILE="index.js"
JS_BUNDLED_FILE="bundle.js"
SASS_ENTRY_FILE="style.scss"
CSS_BUNDLED_FILE="style.css"

NODE_SASS_OPTS="--include-path ./node_modules/bootstrap-sass/assets/stylesheets"
BROWSERIFY_OPTS="-t [ babelify --presets [ es2015 react ] ]"

#-------------------------------------------------------------------------------

function join_path() {
    bash -c 'IFS=/; echo "$*"' -- $*
}
