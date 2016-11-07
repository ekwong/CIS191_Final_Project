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

#takes in a single date in the form of: MM/DD/YYYY
parse_date()
{
	return [[ "$1" =~ (0[0-9]|1[0-2])\/([0-2][0-9]|3[01])\/[0-9]{4} ]]
}

#takes in a task and a due date
add()
{
	#TODO: parse task and due date.
	#add task to tasks.txt file along with due date
	#if valid task name and due date then add to tasks.txt

	#check if task already exists
	if [[ grep -q "$1" "$HOME_DIR/tasks.txt" ]]; then
		if [[ parse_date "$2" ]]; then
			cat "$1 \t $2" >> "$HOME_DIR/tasks.txt"
		else
			echo "Date is not in the correct format"
		fi
	else
		echo "That task already exists in your list"
	fi
}

#takes in a task name
#lets user know if task does not exist
delete()
{
	#TODO: find line that task is on (should limit to only one line) and delete line
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

}

initialize()
{
	if [[ ! -f "./tasks.txt" ]]; then
		touch "$HOME_DIR/tasks.txt"
	fi
}