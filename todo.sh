#!/bin/bash
HOME_DIR=$(pwd)

# check if a line exists in txt file
# takes in filename and line looking for
check_exists()
{
	if grep -q "$1" "$2"; then
		return 1
	else
		return 0
	fi
}

# takes in 2 args
# arg 1 is the assignment
# arg 2 is the due date
# arg 3 is the course
# add_cron hw10 12/06/16 cis191
add_cron()
{
	month=$(date +%m -d "$1"-3days)
	day=$(date +%d -d "$1"-3days)
	hour=$(date +%H -d "$1"-3days)
	min=$(date +%M -d "$1"-3days)

	reminder="echo assignment $2 for course $3 is due on $1"

	crontab -l > temp
	echo "$min $hour $day $month * root $reminder" >> temp
	echo "$min $hour $day $month * root $reminder"
	crontab temp
	rm temp
	echo "reminder created for assignment $2"
}

# create course
# create_course cis191
# creates a course directory with assignments, notes, administration subdirectories
# adds course name to .courses file
# creates .assignments_info file inside assignments
create_course()
{
	if grep -q "$1" "$HOME_DIR/.courses"; then
		echo "$1 already exists as a course"
	else
		echo "$1" >> "$HOME_DIR/.courses"
		mkdir "$HOME_DIR/$1"
		mkdir "$HOME_DIR/$1/assignments"
		touch "$HOME_DIR/$1/assignments/.assignments_info"
		mkdir "$HOME_DIR/$1/notes"
		mkdir "$HOME_DIR/$1/administration"
		echo "$1 has been added as a course"
	fi
}

# delete course
# arg 1 is the course
# deletes the course from .courses but does not delete actual course files themselves
delete_course()
{
	sed -i '' "/$1/d" "$HOME_DIR/.courses"
	echo "$1 has been removed as a course"
}

# create assignment
# first arg is course name
# arg 2 is assignment name
# arg 3 is assignment due date
# creates a directory as assignment name and adds assignment name to .assignments_info
# usage: assignment cis191 hw10 month/day/year
create_assignment()
{
	if grep -q "$2" "$HOME_DIR/$1/assignments/.assignments_info"; then
		echo "$2 is already an assignment in your $1 course"
	else
		due_date=$(date -d "$3")
		echo "$2	$due_date" >> "$HOME_DIR/$1/assignments/.assignments_info"
		mkdir "$HOME_DIR/$1/assignments/$2"
		echo "$2 (due on $3) has been added as an assignment in course $1"
		add_cron $3 $2 $1
	fi
}

# NOTE: use this function for if the assignment already exists, and you just want to update the due date
# this removes the old due date and inserts the new one
# take in 3 args
# arg 1 = course name
# arg 2 = assignment name
# arg 3 = desired due date
update_assignment_date()
{
	# remove the assignment from .assignments_info
	sed -i "/$2/d" "$HOME_DIR/$1/assignments/.assignments_info"
	# add the assignment with updated date to .assignments_info
	due_date=$(date -d "$3")
	echo "$2	$due_date" >> "$HOME_DIR/$1/assignments/.assignments_info"

	# get remove old due date from crontab reminder
	crontab -l > temp
	string="assignment $2 for course $1 is due on"
	sed -i "/$string/d" temp
	crontab temp
	rm temp

	# add new due date to crontab reminder
	add_cron $2 $3 $1
}

# delete assignment
# arg 1 is the course
# arg 2 is the assignment
delete_assignment()
{
	sed -i "/$2/d" "$HOME_DIR/$1/assignments/.assignments_info"
	echo "Assignment $2 has been removed from class $1's assignments"
	crontab -l > temp
	string="assignment $2 for course $1 is due on"
	sed -i "/$string/d" temp
	crontab temp
	rm temp
}

# lists all the courses
list_courses()
{
	echo "Here are your current courses:"
	cat "$HOME_DIR/.courses"
}

# list all assignments
# arg 1 is course
# if no args, list all assignments
list_assignments()
{
	if [[ "$#" -eq 1 ]]; then

		echo "Here are your assignments for $1:"
		cat "$HOME_DIR/$1/assignments/.assignments_info"
	else
		echo "Here are your assignments for all classes"
		while read l; do
			cat "$l/.assignments_info"
		done <$HOME_DIR/.courses
	fi
}

# NOTE: this function assumes the file exists
# arg 1 is course
# arg 2 is assignment
list_files_for_assignment()
{
	ls "$HOME_DIR/$1/assignments/$2"
}

initialize()
{
	if [[ ! -f "$HOME_DIR/.courses" ]]; then
		touch "$HOME_DIR/.courses"
	fi
}
initialize
create_course class1
create_assignment class1 testAssignment1 05/20/16
echo "crontab is"
crontab -l
delete_assignment class1 testAssignment1
echo "crontab after delete is"
crontab -l
# list_courses
# list_assignments
# delete_course testing