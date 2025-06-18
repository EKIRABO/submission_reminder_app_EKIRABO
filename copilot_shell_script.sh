#!/bin/bash
#User input for the new assignment name
read -p "Enter the assignment name:  " names
#Using the find command to search for all the directories with "submission_reminder_* and store it in the Dir variable
Dir=$(find . -type d -name  "submission_reminder_*" | tail -n 1)
echo "found $Dir"
configuration_file=${Dir}/config/config.env
#Convert all characters entered by the user in lower case
	names=$(echo "$names" | tr '[:upper:]' '[:lower:]')
#Replace the assignment value in the config file with the content that the user is going to input as an assignment name	
	sed -i "s/ASSIGNMENT=.*/ASSIGNMENT=\"${names}\"/" "$configuration_file"
	echo "Updated =\"$names\" ASSIGNMENT in config/config.env"
	echo "To see students who have this assignment, do ./startup.sh in the submission_reminder_user_input."
	

