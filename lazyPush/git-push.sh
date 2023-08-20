#!/bin/bash

git add .
read -p "Enter The Commit: " -e -t 20 message
git commit -m "$message"
git push

# Capture the exit status of the git push command

exit_status=$?

# Check the exit status and take appropriate actions
if [ $exit_status -eq 0 ]; then
	echo "Push successful."
elif [ $exit_status -eq 1 ]; then
	echo "Generic error occurred during git push."
elif [ $exit_status -eq 2 ]; then
	echo "Permission denied or repository unavailable."
elif [ $exit_status -eq 128 ]; then
	echo "Fatal error occurred during git push."
elif [ $exit_status -ge 128 ] && [ $exit_status -le 192 ]; then
	echo "Non-fast-forward rejection or other git push error (Exit code: $exit_status)."
elif [ $exit_status -eq 130 ]; then
	echo "Operation canceled."
elif [ $exit_status -eq 131 ]; then
	echo "Remote hang-up."
elif [ $exit_status -eq 141 ]; then
	echo "Pipe broken."
elif [ $exit_status -eq 143 ]; then
	echo "Operation terminated."
else
	echo "Unknown exit code: $exit_status"
fi
