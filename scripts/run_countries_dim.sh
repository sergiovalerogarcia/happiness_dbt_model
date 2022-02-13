#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "============
Run run...
============"
dbt run -s models/countries_dim

echo "============
Run test...
============"
dbt test -s models/countries_dim --exclude tag:integration_tests