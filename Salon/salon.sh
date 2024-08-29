#!/bin/bash
PSQL="psql --username=postgres --dbname=salon -t --no-align -c"

# Numbered list of services
echo "List of services"
LIST_OF_SERVICES="$($PSQL "SELECT service_id, name FROM services")"

# Imprimir cada línea de LIST_OF_SERVICES
echo "$LIST_OF_SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
do
  echo "$SERVICE_ID) $SERVICE_NAME"
done

# If you pick a service that doesn't exist, you should be shown the same list of services again
echo "Choose a service"
read SERVICE_ID_SELECTED

SERVICE_EXISTS=$(echo "$LIST_OF_SERVICES" | grep "^$SERVICE_ID_SELECTED|")
while [[ -z $SERVICE_EXISTS ]]; 
do
  echo "Please select a valid service"
  echo "$LIST_OF_SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  echo "Choose a service"
  read SERVICE_ID_SELECTED
  SERVICE_EXISTS=$(echo "$LIST_OF_SERVICES" | grep "^$SERVICE_ID_SELECTED|")
done

SERVICE_NAME_SELECTED="$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")"

# Ask for info and register
echo "What is your phone number?"
read CUSTOMER_PHONE

LIST_OF_PHONES="$($PSQL "SELECT phone FROM customers")"

PHONE_EXISTS=$(echo "$LIST_OF_PHONES" | grep "^$CUSTOMER_PHONE$")
if [[ -z $PHONE_EXISTS ]]; then
  echo "What is your name?"
  read CUSTOMER_NAME
  INSERT_CUSTOMER="$($PSQL "INSERT INTO customers(name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")"
  echo "Customer successfully registered"
else
  echo "Customer already registered"
fi
CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")"

echo "At what time would you like your appointment?"
read SERVICE_TIME

# Register appointment
INSERT_APPOINTMENT="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")"
echo "I have put you down for a $SERVICE_NAME_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."

exit 0