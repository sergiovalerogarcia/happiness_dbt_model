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
./scripts/run_countries_dim.sh "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

./scripts/run_happiness_facts.sh \
    "world_happiness_dataset_2020" \
    "2020_2021" \
    "2020" \
    "false" \
    "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

echo "============
Run test...
============"
dbt test -s happiness --exclude tag:unit_tests --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'}"

echo "============
Run models incremental...
============"
./scripts/run_happiness_facts.sh \
    "world_happiness_dataset_2021" \
    "2020_2021" \
    "2021" \
    "true" \
    "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

./scripts/run_happiness_facts.sh \
    "world_happiness_dataset_2021" \
    "2020_2021" \
    "2020" \
    "true" \
    "'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)'"

echo "============
Run test incremental...
============"
dbt test -s tests/integration_tests/happiness_facts/itest_happiness_facts_incremental.sql \
    --vars "{'integration_tests':'true','unique_identifier':'$(cat logs/unique_identifier_it)','incremental_tests':'true'}"
