#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuple-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
fi
