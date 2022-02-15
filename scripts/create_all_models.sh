#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "============
Seeds and copy...
============"
./scripts/copy_tables_using_seeds_schemas.sh "~/workspace/data/dbt/dbt_testing/happiness/discovery/data/world_happiness_dataset"

echo "============
Run models...
============"
./scripts/run_countries_dim.sh ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2015" \
    "2015_2016" \
    "2015" \
    "false" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2016" \
    "2015_2016" \
    "2016" \
    "true" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2017" \
    "2017" \
    "2017" \
    "true" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2018" \
    "2018_2019" \
    "2018" \
    "true" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2019" \
    "2018_2019" \
    "2019" \
    "true" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2020" \
    "2020_2021" \
    "2020" \
    "true" ""

./scripts/run_happiness_facts.sh \
    "happiness.world_happiness_dataset_2021" \
    "2020_2021" \
    "2021" \
    "true" ""

echo "============
Run test...
============"
dbt test -s happiness --exclude tag:unit_tests tag:integration_tests
