#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guessing_game -t --no-align -c"
SECRET_NUMBER=$((RANDOM%1000+1))

echo -e "Enter your username:"
read USERNAME
CHECK_NAME_RESULT=$($PSQL "SELECT * FROM usernames WHERE username = '$USERNAME'")
if [[ -z $CHECK_NAME_RESULT ]]
then
echo "Welcome, $USERNAME! It looks like this is your first time here."
GAMES_PLAYED=0
BEST_GAME=999999
INSERT_USER_RESULT=$($PSQL "INSERT INTO usernames(username, best_game, games_played) VALUES ('$USERNAME', 999999, 0)")
else
IFS="|" read ID USERNAME BEST_GAME GAMES_PLAYED <<< $CHECK_NAME_RESULT
echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi




echo "Guess the secret number between 1 and 1000:"
read GUESSED_NUMBER

NUMBER_OF_GUESSES=1
while [[ $GUESSED_NUMBER != $SECRET_NUMBER  ]]
do
re='^[0-9]+$'
if ! [[ $GUESSED_NUMBER =~ $re ]]
then
echo -e "\nThat is not an integer, guess again:"
read GUESSED_NUMBER
continue
elif [[ $GUESSED_NUMBER -gt $SECRET_NUMBER ]]
then
echo -e "\nIt's lower than that, guess again:"
read GUESSED_NUMBER
NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
else 
echo -e "It's higher than that, guess again:"
read GUESSED_NUMBER
NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))

fi
done


if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
then
UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE usernames SET best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
fi
UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE usernames SET games_played = $GAMES_PLAYED + 1 WHERE username = '$USERNAME'") 
echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

