#!/bin/bash
# get the number of argument passed and hence ask for an alternative if no argument is passed 
if [ $# -lt 1 ]; then 
	read -p "Do you wish to add all (y) or (n): " choice

	if  [[ "$choice" == "y" || "$choice" == "Y" ]]; then
		git add .
	else
		echo "Nothing to add. Exiting."
		exit 1
	fi
fi

# git add the file based on the number of argument passed
for arg in "$@"; do
	if [ -n "$arg" ]; then
		git add "$arg"
	else
		echo "Skipping empty argument."
	fi
done

# output the files that added
echo "Added the following"
echo "$@"

read -p -e "\nEnter The Commit: "  message
git commit -m "$message"

current_branch=$(git symbolic-ref --short HEAD) # get the branch name 

# push from the branch name 
if [ -n "$current_branch" ]; then
	git push origin "$current_branch"
else
	echo "Unable to determine the current branch. Make sure you are on a valid branch."
	exit 1
fi

# Capture the exit status of the git push command
#exit_status=$?

# Check the exit status and take appropriate actions
#if [ $exit_status -eq 0 ]; then
#	echo "Push successful."
#elif [ $exit_status -eq 1 ]; then
#	echo "Generic error occurred during git push."
#elif [ $exit_status -eq 2 ]; then
#	echo "Permission denied or repository unavailable."
#elif [ $exit_status -eq 128 ]; then
#	echo "Fatal error occurred during git push."
#elif [ $exit_status -ge 128 ] && [ $exit_status -le 192 ]; then
#	echo "Non-fast-forward rejection or other git push error (Exit code: $exit_status)."
#elif [ $exit_status -eq 130 ]; then
#	echo "Operation canceled."
#elif [ $exit_status -eq 131 ]; then
#	echo "Remote hang-up."
#elif [ $exit_status -eq 141 ]; then
#	echo "Pipe broken."
#elif [ $exit_status -eq 143 ]; then
#	echo "Operation terminated."
#else
#	echo "Unknown exit code: $exit_status"
#fi   ***/
