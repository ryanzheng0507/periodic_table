#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

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

PROPERTIES_TABLE=$($PSQL "SELECT * FROM properties ORDER BY atomic_number")
echo "$PROPERTIES_TABLE" | while read ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE_ID
do
if [[ $ATOMIC_NUMBER = $1 ]]
then
ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
NAME_FORMATTED=$(echo $ATOMIC_NAME | sed -r 's/^ *| *$//g')
TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
TYPE_FORMATTED=$(echo $TYPE | sed -r 's/^ *| *$//g')
ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
SYMBOL_FORMATTED=$(echo $ATOMIC_SYMBOL | sed -r 's/^ *| *$//g')
echo "The element with atomic number $ATOMIC_NUMBER is $NAME_FORMATTED ($SYMBOL_FORMATTED). It's a $TYPE_FORMATTED, with a mass of $ATOMIC_MASS amu. $NAME_FORMATTED has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
fi
done
