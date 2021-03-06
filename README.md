# Local News Engine

Currently just a selection of scripts.

You will need Python3 (with virtualenv), NPM and golang installed - e.g. on Ubuntu

```
sudo aptitude install python3-virtualenv npm golang
```

Install python requirements
```
python3 -m virtualenv --python=python3 .ve
source .ve/bin/activate
pip install -r requirements.txt
```

Install javascript requirements
```
npm install .
```


## The Scrapers

The scrapers should put there results in the data directory. Apart from the courts data that lives in the courts_data directory.

### Courts

Get a courts file put it in the data directory and use pdftotext on it with layout command.

```
pdftotext -layout courts_data/courts.pdf
```
Then run parse the data which creates courts.txt

```
python courts_parse.py
```

### Licensing and planning data

```
python islington_license.py 
python islington_planning.py 
python camden_license.py 
```
In order to rerun these the files created must me removed or moved.

For camden planning

```
cd data
wget https://opendata.camden.gov.uk/resource/mcgw-i4rx.json
cd ..
```


## Processing The data

All processed data can be found in the processed directory.

### Name matching

To get the interesting set of names run

```
python name_matches.py
```

This also runs the go matching webserver in the background and kills it once used.

### Area matching

To get the area matches run 
```
python area_matches.py
```

### Running without the courts data

Create a dummy courts data file:

```
echo '[]' > courts_data/courts.json 
```

## Generating the html

All html found in output directory.

Firstly the frontend templates need to be compiled
```
node_modules/.bin/nunjucks-precompile templates_nunjucks > output/templates.js
```

Then to generate the final html

```
python generate_html.py
```


