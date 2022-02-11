#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "$(date +%s)" > logs/unique_identifier_it

echo unique_identifier_it is $(cat logs/unique_identifier_it)

dbt seed -s happiness --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"

dbt run -s happiness --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"

dbt test -s tag:integration_tests,happiness --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"