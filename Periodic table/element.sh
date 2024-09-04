#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Introduction
USERS_SELECTION=$1
if [ -z "$1" ]; then
    echo "Please provide an element as an argument."
    exit 0
fi

# Check if the input is numeric or a string
if [[ $USERS_SELECTION =~ ^[0-9]+$ ]]; then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$USERS_SELECTION;")
else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$USERS_SELECTION' OR symbol='$USERS_SELECTION';")
fi

# If it doesn't exist
if [[ -z $ATOMIC_NUMBER ]]; then
    echo "I could not find that element in the database."
    exit 0
fi

# Type
TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER");
if [[ $TYPE_ID == 1 ]]; then
  TYPE='nonmetal'
elif [[ $TYPE_ID == 2 ]]; then
  TYPE='metal'
else
  TYPE='metalloid'
fi

# Read every column of the tables
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER");
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER");
MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER");
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER");
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER");

# Give an answer
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
exit 0