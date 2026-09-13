#!/bin/bash
PSQL="psql -t --username=freecodecamp --dbname=salon -c "

MAIN_MENU()
{
if [[ ! -z $1 ]]
then
echo $1
MAIN_MENU
else 
  echo -e "\nWhat is the service you want to make an appointment"
  echo "1) haircut"
  echo "2) trimming"
  echo "3) waxxing"
  echo "4) nail service"
  echo "5) hair stylist"
  echo "6) exit"

  read SERVICE_ID_SELECTED
  
  if [[ $SERVICE_ID_SELECTED =~ ^[1-5]$ ]]
  then
  ORDER_SERVICE $SERVICE_ID_SELECTED
  elif [[ $SERVICE_ID_SELECTED != "6" ]]
  then
  MAIN_MENU "Input you just entered invalid. Please try again."

  fi
fi
}

ORDER_SERVICE()
{
echo $1
echo -e "\nEnter your phone number:"
read CUSTOMER_PHONE
CHECK_PHONE_LIST_RESULT=$($PSQL "SELECT * FROM customers WHERE phone = '$CUSTOMER_PHONE'")
echo $CHECK_PHONE_LIST_RESULT
if [[ -z $CHECK_PHONE_LIST_RESULT ]]
then
# read and insert new customer 
echo -e "\nEnter your name"
read CUSTOMER_NAME
INSERT_CUSTOMER_NAME_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES ('$CUSTOMER_NAME','$CUSTOMER_PHONE')")

fi

# read CUSTOMER_ID
READ_CUSTOMER_ID_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
# read SERVICE_TIME
echo -e "Please write the time you want to appointment us"
read SERVICE_TIME


MAKE_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES ('$SERVICE_TIME',$READ_CUSTOMER_ID_RESULT,$1)")

# get info from table 
GET_SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $1")

# print the info
echo "I have put you down for a $GET_SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

}


MAIN_MENU