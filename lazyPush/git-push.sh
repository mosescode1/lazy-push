#!/bin/bash

git add .
read -p "Enter The Commit: " message
git commit -m "$message"

output=$(git push 2>&1)

# Check if the output contains the word "error"
if echo "$output" | grep -i "error"; then
	echo "An error was detected in the output."
else
	echo "Push Successful"
fi
