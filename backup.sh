#!/bin/bash

heroku pg:psql -c "COPY learnt_items TO STDOUT WITH CSV HEADER;" | cut -d "," -f 2-
