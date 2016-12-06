#!/bin/bash
HOME_DIR=$(pwd)

#check if a line exists in txt file
#takes in filename and line looking for
check_exists()
{
	if grep -q "$1" "$2"; then
		return 1
	else
		return 0
	fi
}

#takes in 2 args
#arg 1 is the assignment
#arg 2 is the due date
add_cron()
{
	month=$(date +%m -d "$1"-1day)
	day=$(date +%d -d "$1"-1day)
	hour=$(date +%H -d "$1"-1day)
	min=$(date +%M -d "$1"-1day)

	reminder="echo $2 is due on $1"

	crontab -l > temp
	echo "$min $hour $day $month * root $reminder" >> temp
	echo "$min $hour $day $month * root $reminder"
	crontab temp
	rm temp
	echo "reminder created for assignment $2"
}

#create course
create_course()
{
	if grep -q "$1" "$HOME_DIR/courses.txt"; then
		echo "$1 already exists as a course"
	else
		echo "$1" >> "$HOME_DIR/courses.txt"
		mkdir "$HOME_DIR/$1"
		touch "$HOME_DIR/$1/assignments.txt"
		echo "$1 has been added as a course"
	fi
}

#delete course
#arg 1 is the course
delete_course()
{
	sed -i '' "/$1/d" "$HOME_DIR/courses.txt"
	rm -r "$HOME_DIR/$1"
	echo "$1 has been removed as a course"
}

# create assignment
#first arg is course name
#arg 2 is assignment name
#arg 3 is assignment due date
#creates a directory as assignment name and adds assignment name to assignments.txt
#usage: assignment cis191 hw10 month/day/year
create_assignment()
{
	if grep -q "$2" "$HOME_DIR/$1/assignments.txt"; then
		echo "$2 is already an assignment in your $1 course"
	else
		due_date=$(date -d "$3")
		echo "$2	$due_date" >> "$HOME_DIR/$1/assignments.txt"
		mkdir "$HOME_DIR/$1/$2"
		echo "$2 (due on $3) has been added as an assignment in course $1"
		add_cron $3 $2
	fi
}

# delete assignment
#arg 1 is the course
#arg 2 is the assignment
delete_assignment()
{
	sed -i '' "/$2/d" "$HOME_DIR/$1/assignments.txt"
	rm -r "$HOME_DIR/$1/$2"
	echo "Assignment $2 has been removed from class $1's assignments"
	crontab -l > temp
	sed -i "/assignment $2 for course $1 is due/d" temp
	crontab temp
	rm temp
}

#lists all the courses
list_courses()
{
	echo "Here are your current courses:"
	cat "$HOME_DIR/courses.txt"
}

#list all assignments
#arg 1 is course
#if no args, list all assignments
list_assignments()
{
	if [[ "$#" -eq 1 ]]; then

		echo "Here are your assignments for $1:"
		cat "$HOME_DIR/$1/assignments.txt"
	else
		echo "Here are your assignments for all classes"
		while read l; do
			cat "$l/assignments.txt"
		done <$HOME_DIR/courses.txt
	fi
}


#arg 1 is course
#arg 2 is assignment
list_assignment_contents()
{
	ls "$HOME_DIR/$1/$2"
}

initialize()
{
	if [[ ! -f "$HOME_DIR/courses.txt" ]]; then
		touch "$HOME_DIR/courses.txt"
	fi
}
initialize
create_course class1
create_assignment class1 testAssignment 05/06/16
# list_courses
# list_assignments
# delete_course testing