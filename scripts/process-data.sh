#!/bin/bash

# Get the command-line arguments
payload_json_original="$1"
timestamp_property_to_add="$2"

# Parse the JSON string into a shell variable
payload_json=$(echo "$payload_json_original" | jq -c '.')

# Add a timestamp property to the object if timestamp_property_to_add is not empty
if [[ -n "$timestamp_property_to_add" ]]; then
  timestamp_utc=$(date -u +%FT%T%Z)
  payload_json=$(echo "$payload_json" | jq --arg timestamp_utc "$timestamp_utc" --arg timestamp_property "$timestamp_property_to_add" '. + {($timestamp_property): $timestamp_utc}')
fi

# Output the modified JSON string
echo "processed payload:"
echo "$payload_json"

# Remove linebreaks from the modified JSON string
payload_json=$(echo "$payload_json" | tr -d '\n')

echo "$payload_json"
echo "payload_json=$payload_json" >> $GITHUB_ENV
