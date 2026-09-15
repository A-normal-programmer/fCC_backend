#!/bin/bash
PSQL="psql -t --username=freecodecamp --dbname=periodic_table -t --no-align -c"

STRING_EXECUTE ()
{
  local input="$1"
  IFS="|" read atomic_number atomic_mass melting_point_celsius boiling_point_celsius type_id atomic_number symbol name type_id type <<< "$input" 
  echo "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
}

INPUT_NUM=$1
declare -i INPUT_NUM

# if not insert any argument
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else

# if not found the input is a symbol :
CHECK_SYMBOL=$($PSQL "SELECT * FROM properties INNER JOIN elements ON (properties.atomic_number=elements.atomic_number) LEFT JOIN types ON (types.type_id =properties.type_id) WHERE symbol = '$1'")
if [[ -z $CHECK_SYMBOL ]]
then

# if not found the input is a name either:
CHECK_NAME=$($PSQL "SELECT * FROM properties INNER JOIN elements ON (properties.atomic_number=elements.atomic_number) LEFT JOIN types ON (types.type_id =properties.type_id) WHERE name = '$1'")
if [[ -z $CHECK_NAME  ]]
then

# if input is a number:
if [[ $1 =~ ^[0-9]+$ ]]
then
# if not found the input is an atomic_number:
CHECK_ATOMIC_NUMBER=$($PSQL "SELECT * FROM properties INNER JOIN elements ON (properties.atomic_number=elements.atomic_number) LEFT JOIN types ON (types.type_id =properties.type_id) WHERE elements.atomic_number = $INPUT_NUM ")
if [[ -z $CHECK_ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."

else
STRING_EXECUTE $CHECK_ATOMIC_NUMBER

fi

else
echo "I could not find that element in the database."

fi

else
STRING_EXECUTE $CHECK_NAME

fi

else
STRING_EXECUTE $CHECK_SYMBOL

fi

fi





















