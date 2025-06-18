# submission_reminder_app_EKIRABO
This app serves as a reminder to the students who haven't submitted an assignment and instructors who want to track assignment submissions of their students. 
Designed for educational purpose only.

Overview:
1. Creates all directories and files (With scripts and templayes)
2. Prompt the user for name and assignment details
3. Checking students with pending submissions and those who submited
4.Records and displays reminders.

How the app works :
1. First, copy the project from GitHub to your machine using git clone as follows:
git clone https://<YOUR_GITHUB_TOKEN>@github.com/<your-username>/<your-repo-name>.git
cd submission_reminder_app_$repositoryname
2. First run the create_environment.sh script and it will prompt you as the user for a name.Enter your name and the directory structure will get created and stored inside the main directory which is submission_reminder_$name
3. Then run the the copilot_shell_script.sh script and it will update the assignment that the user inputed in config/config.env
4. Then run startup.sh to check the submission status of students according to the assignment the user inputed.

Step by Step Usage:

.Starting with the create_environment.sh scipt:
*Creates a directory structure that looks like this:
submission_reminder_$userinput/
├── app/
│   └── reminder.sh
├── modules/
│   └── functions.sh
├── config/
│   └── config.env
├── assets/
│   └── submissions.txt
└── startup.sh

*Insert contents into each file using the cat command and paste them at the beginning of the file using BOF like this: CAT<<BOF > path_of_thefile
* Creates a startup.sh script that contains logic that starts up the reminder app when executed.

.Moving on to the copilot_shell_script.sh script:
*Run the copilot script (./copilot_shell_script.sh) and it will ask you to type the assignment name 
*Automatically update the ASSIGNMENT variable in the config/config.env file.

