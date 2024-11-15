#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuple-only -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
elif [[ $1 =~ [0-9]+ ]]
then
ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
if [[ -z $ATOMIC_NAME ]]
then
echo "I could not find that element in the database."
fi
elif [[ $1 =~ [A-Z] ]] || [[ $1 =~ [A-Z][a-z] ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = $1")
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
fi
elif [[ $1 =~ [A-Z][a-z]+ ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = $1")
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
fi
fi
