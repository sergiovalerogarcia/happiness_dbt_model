#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

EXTRA_VARS=$1

echo "============
Run run...
============"
dbt run -s happiness.countries_dim.countries_dim --vars "{$EXTRA_VARS}"

echo "============
Run test...
============"
dbt test -s happiness.countries_dim.countries_dim --exclude tag:integration_tests --vars "{$EXTRA_VARS}"