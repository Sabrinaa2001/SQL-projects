#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Pedir el nombre de usuario
echo "Enter your username:"
read INPUT_USERNAME


# Check if the username length is valid
if [[ ${#INPUT_USERNAME} -gt 22 ]]; then
  echo "Username should be at most 22 characters long."
  exit 1
fi

# Verificar si el nombre de usuario existe en la base de datos
USERNAME=$($PSQL "SELECT username FROM user_data WHERE username='$INPUT_USERNAME'");

if [[ -n $USERNAME ]]; then
  # Si el nombre de usuario ya existe
  NUMBER_OF_GAMES=$($PSQL "SELECT number_of_games FROM user_data WHERE username='$USERNAME'")
  BEST_SCORE=$($PSQL "SELECT best_score FROM user_data WHERE username='$USERNAME'")
  
  # Mostrar el mensaje correcto
  echo "Welcome back, $USERNAME! You have played $NUMBER_OF_GAMES games, and your best game took $BEST_SCORE guesses."
else
  # Si el nombre de usuario no existe, agregarlo a la base de datos
  INSERT_USER_DATA=$($PSQL "INSERT INTO user_data(username, number_of_games, best_score) VALUES('$INPUT_USERNAME', 0, 1000000)")
  
  # Mostrar el mensaje para nuevos usuarios
  echo "Welcome, $INPUT_USERNAME! It looks like this is your first time here."
  
  # Establecer valores iniciales
  USERNAME=$INPUT_USERNAME
  NUMBER_OF_GAMES=0
  BEST_SCORE=1000000
fi

# Create random number
RANDOM_NUM=$(( (RANDOM % 1000) + 1 ))
echo "Guess the secret number between 1 and 1000:"

# Counter
TRIES=0;

# If not an integer
while true; do
  read INPUT_NUMBER

  # Verify if the input is an integer
  if [[ $INPUT_NUMBER =~ ^[0-9]+$ ]]; then
    break
  else
    echo "That is not an integer, guess again:"
  fi
done

# Guessing loop
while [[ $INPUT_NUMBER -ne $RANDOM_NUM ]]; do
  if [[ $INPUT_NUMBER -lt $RANDOM_NUM ]]; then
    echo "It's higher than that, guess again:"
  else
    echo "It's lower than that, guess again:"
  fi
  read INPUT_NUMBER
  TRIES=$(($TRIES + 1))
done

# Increment game count and update best score
NUMBER_OF_GAMES=$(($NUMBER_OF_GAMES + 1))
TRIES=$(($TRIES + 1))

if [[ $TRIES -lt $BEST_SCORE ]]; then
  BEST_SCORE=$TRIES
fi

# Update user data
UPDATE_USER_DATA=$($PSQL "UPDATE user_data SET number_of_games=$NUMBER_OF_GAMES, best_score=$BEST_SCORE WHERE username='$USERNAME'")

echo "You guessed it in $TRIES tries. The secret number was $RANDOM_NUM. Nice job!"
exit 0