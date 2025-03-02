#!/usr/bin/env sh

# Iterate through all environment variables ending with __FILE
for secret in /run/secrets/*; do
  var="$(echo "${secret#/run/secrets/}" | tr '[:lower:]' '[:upper:]')"

  # Export the new variable with the content of the file
  export "$var"="$(cat "$secret")"
done

# Execute the passed command with arguments
exec "$@"
