#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

WORLD_HAPPINESS_DATASET=$1
YEAR_LIKE=$2
YEAR=$3
TABLE_EXISTS=$4
EXTRA_VARS=$5

echo "============
Run run...
============"
dbt run -s models/happiness_facts \
    --vars "{'world_happiness_dataset':'$WORLD_HAPPINESS_DATASET','year_like':'$YEAR_LIKE','year':'$YEAR','table_exists':'$TABLE_EXISTS',$EXTRA_VARS}"

echo "============
Run test...
============"
dbt test -s models/happiness_facts --exclude tag:integration_tests --vars "{$EXTRA_VARS}"