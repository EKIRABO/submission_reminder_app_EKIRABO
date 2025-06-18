#!/bin/bash
#User input for the new assignment name
read -p "Enter the assignment name:  " names
Dir=$(find . -type d -name  "submission_reminder_*" | tail -n 1)
echo "found $Dir"
configuration_file=${Dir}/config/config.env
	names=$(echo "$names" | tr '[:upper:]' '[:lower:]')
	sed -i "s/ASSIGNMENT=.*/ASSIGNMENT=\"${names}\"/" "$configuration_file"
	echo "Updated =\"$names\" ASSIGNMENT in config/config.env"
	echo "To see students who have this assignment, do ./startup.sh in the submission_reminder_user_input"
	

