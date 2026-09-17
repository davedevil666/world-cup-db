#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database
echo $($PSQL "TRUNCATE TABLE games, teams")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != year ]]
then
#get team ID
TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
#if not found
if [[ -z $TEAM_ID ]]
then
#insert team
INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
then
echo "Inserted into teams, $WINNER"
fi

fi
#get winner_id
WINNER_ID=$($PSQL "SELECT team_id from teams WHERE name = '$WINNER'")
#echo "$WINNER_ID"
#------------------
#get team ID
TEAM_ID=$($PSQL "SELECT team_id from teams WHERE name = '$OPPONENT'")
#if not found
if [[ -z $TEAM_ID ]]
then
#insert team
#TEAM_NAME=$($PSQL "SELECT name ")
INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
then
echo "Inserted into teams, $OPPONENT"
fi

fi
#get opponent_id
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
#echo "$OPPONENT_ID"

INSERT_GAME_RESUL=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
              VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
fi
done

