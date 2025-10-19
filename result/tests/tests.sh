#!/bin/sh

# Wait for the 'vote' service to be reachable
while ! nc -z vote 80 2>/dev/null; do
    sleep 1
done

curl -sS -X POST --data "vote=b" http://vote > /dev/null
sleep 10

if phantomjs render.js http://result | grep -q '1 vote'; then
  echo -e "\e[42m------------"
  echo -e "\e[92mTests passed"
  echo -e "\e[42m------------"
  exit 0
else
  echo -e "\e[41m------------"
  echo -e "\e[91mTests failed"
  echo -e "\e[41m------------"
  exit 1
fi
