#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

CONNECTION=postgresql://$USER:$PASSWORD@$HOST:$PORT/$DBNAME
DATA_PATH="~/workspace/data/dbt/dbt_testing/happiness/discovery/data/world_happiness_dataset"

copy_table_using_seed_schema() {
    TABLE=$1
    EXAMPLE=$2
    FILE=$3

    echo $TABLE
    psql $CONNECTION -c "create schema if not exists happiness"
    psql $CONNECTION -c "create table if not exists $TABLE as select * from $EXAMPLE"
    psql $CONNECTION -c "truncate table $TABLE"
    psql $CONNECTION -c "\copy $TABLE from '$FILE' csv header"
}

TABLE_PREFIX="happiness.world_happiness_dataset"
TABLE_TEST_PREFIX="happiness_tests.world_happiness_dataset_example"

dbt seed -s happiness

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2015" \
    "${TABLE_TEST_PREFIX}_2015" \
    "${DATA_PATH}/2015.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2016" \
    "${TABLE_TEST_PREFIX}_2016" \
    "${DATA_PATH}/2016.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2017" \
    "${TABLE_TEST_PREFIX}_2017" \
    "${DATA_PATH}/2017.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2018" \
    "${TABLE_TEST_PREFIX}_2018_2019" \
    "${DATA_PATH}/2018.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2019" \
    "${TABLE_TEST_PREFIX}_2018_2019" \
    "${DATA_PATH}/2019.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2020" \
    "${TABLE_TEST_PREFIX}_2020_2021" \
    "${DATA_PATH}/2020.csv"

copy_table_using_seed_schema \
    "${TABLE_PREFIX}_2021" \
    "${TABLE_TEST_PREFIX}_2020_2021" \
    "${DATA_PATH}/2021.csv"
