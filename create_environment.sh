#!/bin/bash
#Prompt the user for their name
read -p "Enter your name: " name
submissions="submission_reminder_$name"
#Using the if condition to create the directory structure
if [ ! -d $submissions ]; then
	mkdir $submissions
	cd $submissions
	mkdir -p app && cd app && touch reminder.sh
	cd ..
	mkdir -p modules && cd modules && touch functions.sh
	cd ..
	mkdir -p assets && cd assets && touch submissions.txt
	cd ..
	mkdir -p config && cd config && touch config.env
	cd ..
	touch startup.sh
else 
	cd $submissions
	mkdir -p app && cd app && touch reminder.sh
        cd ..
        mkdir -p modules && cd modules && touch functions.sh
        cd ..
        mkdir -p assets && cd assets && touch submissions.txt
        cd ..
        mkdir -p config && cd config && touch config.env
        cd ..
        touch startup.sh	
fi
#Using the cat command to add the texts inside the file
#Using BOF to put the text at the beginning of the file
	chmod +x app/reminder.sh
	cat <<BOF >> app/reminder.sh
	#!/bin/bash

	# Source environment variables and helper functions
	source ./config/config.env
	source ./modules/functions.sh

	# Path to the submissions file
	submissions_file="./assets/submissions.txt"

	# Print remaining time and run the reminder function
	echo "Assignment: $ASSIGNMENT"
	echo "Days remaining to submit: $DAYS_REMAINING days"
	echo "--------------------------------------------"

	check_submissions $submissions_file
BOF
	chmod +x modules/functions.sh
	cat <<BOF >> modules/functions.sh
	#!/bin/bash

	# Function to read submissions file and output students who have not submitted
	function check_submissions {
    local submissions_file=$1

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
	}
BOF
	cat <<BOF > assets/submissions.txt
student, assignment, submission status, Days_left
Chinemerem, Shell Navigation, not submitted, 2
Chiagoziem, Git, submitted, 4
Divine, Shell Navigation, not submitted, 2
Anissa, Shell Basics, submitted, 1
Anita, Shell Basics, not submitted, 1
Nice, Shell IO Redirections, submitted, 5
Esther, Shell loops, submitted, 3
Annie, Emacs, submitted, 1
Kevine, vim, submitted, 1
Bryan, nano, not submitted, 0
BOF
	cat <<BOF >> config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
BOF
#Creating a startup script that displays students status for the assignment chosen in the copilot script
chmod +x startup.sh
#!/bin/bash
cat <<BOF > ./startup.sh
source ./config/config.env
tail -n +2 "./assets/submissions.txt" | while IFS=',' read -r student assignment status Days_left; do
        student=\$(echo "\$student" | xargs)
	assignment=\$(echo "\$assignment" | tr '[:upper:]' '[:lower:]' | xargs | sed 's/^"\(.*\)"$/\1/')
        status=\$(echo "\$status" | tr '[:upper:]' '[:lower:]' | xargs)
	Days_left=\$(echo "\$Days_left" | xargs)
	if [[ "\$status" == "submitted" && "\$assignment" == "\$ASSIGNMENT" ]]; then
		echo "Congratulations \$student submitted \$assignment assignment"
	elif [[ "\$status" == "not submitted" && "\$assignment" == "\$ASSIGNMENT" ]]; then
        	echo "Reminder: \$student has not submitted the \$assignment assignment and it is due in \$Days_left days!"
	fi
	done
BOF

