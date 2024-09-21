#!/bin/bash

# URL of the application
APP_URL="http://your-application-url.com"

# Send an HTTP request and get the status code
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" $APP_URL)

# Check if the status code is 200 (OK)
if [ $STATUS_CODE -eq 200 ]; then
  echo "Application is up! Status code: $STATUS_CODE"
else
  echo "Application is down! Status code: $STATUS_CODE" >> app_health.log
fi
