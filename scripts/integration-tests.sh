#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "$(date +%s)" > logs/unique_identifier_it

echo unique_identifier_it is $(cat logs/unique_identifier_it)

echo "============
Run seeds...
============"

dbt seed -s seeds/raw_examples/ --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"

echo "============
Run models...
============"
dbt run -s happiness --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"

echo "============
Run test...
============"
dbt test -s happiness --exclude tag:unit_tests --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"