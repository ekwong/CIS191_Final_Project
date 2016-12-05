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

delete_course()
{
	sed -i '' "/$1/d" "$HOME_DIR/courses.txt"
	rm -r "$HOME_DIR/$1"
	echo "$1 has been removed as a course"
}
# create assignment
# delete assignment
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

#takes in a task name
#lets user know if task does not exist
delete()
{
	#TODO: find line that task is on (should limit to only one line) and delete line
	return 0
}

#lists all the tasks and their due dates
list()
{
	echo "Here are your current tasks and their due dates:"
	cat "$HOME_DIR/tasks.txt"
}

#updates a due date for an existing task
#throw an error if that task does not exist
update()
{
	return 0
}

initialize()
{
	if [[ ! -f "$HOME_DIR/courses.txt" ]]; then
		touch "$HOME_DIR/courses.txt"
	fi
}
initialize
create_course testing
create_course class1
delete_course testing
# delete_course testing
