#!/bin/bash

# API URL for Pikachu
API_URL="https://pokeapi.co/api/v2/pokemon/pikachu/"

# Output files
SUCCESS_FILE="data.json"
ERROR_FILE="errors.txt"

# Make the API request and handle errors
response=$(curl --write-out "%{http_code}" --silent --output temp_response.json "$API_URL")

# Check if the request was successful
if [ "$response" -eq 200 ]; then
  # If successful, move the response to data.json
  mv temp_response.json "$SUCCESS_FILE"
  echo "Request successful. Data saved to $SUCCESS_FILE."
else
  # If failed, save the error message to errors.txt
  echo "Error: API request failed with response code $response" >> "$ERROR_FILE"
  echo "Error details saved to $ERROR_FILE."

  # Only attempt to read and delete temp_response.json if it exists
  if [ -f temp_response.json ]; then
    cat temp_response.json >> "$ERROR_FILE"
    rm temp_response.json
  fi
fi

