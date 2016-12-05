#!/bin/bash
HOME_DIR=$(pwd)

main()
{
	for arg in "$@"
	do
		case $arg in
			"add")
				shift
				add "$@"
				;;
			"delete")
				shift
				delete "$@"
				;;
			"list")
				list
				;;
			"update")
				shift
				update "$@"
				;;
			*) ;;
		esac
	done
}
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
}
# create exam
# delete exam

#takes in a single date in the form of: MM/DD/YYYY
# parse_date()
# {
# 	return [[ "$1" =~ (0[0-9]|1[0-2])\/([0-2][0-9]|3[01])\/[0-9]{4} ]]
# }

#takes in a task and a due date
# add()
# {
# 	#TODO: parse task and due date.
# 	#add task to tasks.txt file along with due date
# 	#if valid task name and due date then add to tasks.txt

# 	#check if task already exists
# 	# if grep -q "$1" "$HOME_DIR/tasks.txt" then
# 	# 	if [[ parse_date "$2" ]]; then
# 	# 		cat "$1 \t $2" >> "$HOME_DIR/tasks.txt"
# 	# 	else
# 	# 		echo "Date is not in the correct format"
# 	# 	fi
# 	# else
# 	# 	echo "That task already exists in your list"
# 	# fi
# }

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
		done <courses.txt
	fi
}

initialize()
{
	if [[ ! -f "$HOME_DIR/courses.txt" ]]; then
		touch "$HOME_DIR/courses.txt"
	fi
}
initialize
create_course class1
create_assignment class1 testAssignment 05/06
list_courses
list_assignments
# delete_course testing
