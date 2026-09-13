#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

x=$($PSQL "TRUNCATE games CASCADE");
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != 'year' ]]
then

# ~~ start of the loop ~~


echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS

# check if winner team already in teams table or not
CHECK_WINNER_TEAM=$($PSQL "SELECT * FROM teams WHERE name = '$WINNER'")
echo $CHECK_WINNER_TEAM
if [[ -z $CHECK_WINNER_TEAM  ]]
then
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
echo $INSERT_TEAM_RESULT
fi

# check if opponent team already in teams table or not
CHECK_OPPONENT_TEAM=$($PSQL "SELECT * FROM teams WHERE name = '$OPPONENT'")
echo $CHECK_OPPONENT_TEAM
if [[ -z $CHECK_OPPONENT_TEAM  ]]
then
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
echo $INSERT_TEAM_RESULT
fi

# insert into games table
  # get winner_id
  WINNER_ID=$($PSQL "SELECT team_id from teams WHERE name = '$WINNER'")
  # get opponent_id
  OPPONENT_ID=$($PSQL "SELECT team_id from teams WHERE name = '$OPPONENT'")
INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")


# ~~ end of the loop ~~

fi
done

echo $($PSQL "SELECT * FROM teams")
echo $($PSQL "SELECT * FROM games")