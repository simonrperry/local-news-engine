#!/bin/bash

set -e

test -d data || echo "data dir not found"
test -d .git || echo "not the root of a git repo - you're probably in the wrong place"
which mail 1>/dev/null 2>/dev/null || echo "mail not found"

read -p "Before proceeding, ensure that you have run all scrapers, parsed the courts data and have a cup of coffee. Press [Enter] to continue:"

source bin/activate

echo "Performing area matching..."
python area_matches.py

echo "Performing name matching..."
python name_matches.py

echo "Compiling templates..."
node_modules/.bin/nunjucks-precompile templates_nunjucks > output/templates.js

echo "Generating HTML..."
python generate_html.py

echo "Creating .zip archive..."
zip local_news_engine$(date +"%d_%m_%y").zip output/names.html output/areas.html

message=<<EOF
Hi!

This is the latest delivery from the Local News Engine. Enjoy!

EOF

echo $message $(uuencode local_news_engine$(date +"%d_%m_%y").zip local_news_engine$(date +"%d_%m_%y").zip) | mail rob.redpath@opendataservices.coop
