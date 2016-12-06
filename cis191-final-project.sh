#!/bin/sh

#create a new semester folder
case $1 in
    init ) 
        shift
        while getopts ":s:" opt; do
           case $opt in
           s )  semester=$OPTARG ;;
           esac
        done
    
        if [[ (-z "$semester") ]] ; then
            echo "semester is required to create semester directory"
            exit
        fi;

        mkdir "$semester"
        cd "$semester"
        touch ".main"

        echo "init semester command"
        exit;
    ;;    
esac

#when this code is run, check that you are in a directory or sub directory of a semester folder
foundInitFile=false
while [[ "$PWD" != "/" ]] ; do

    
    if [[ -f ".main" ]]; then
        foundInitFile=true
        break
    fi
    cd ..
done

if [[ "$foundInitFile" == "false" ]]; then
    echo "no semester folder was found"
    exit
fi

#parse incoming commands
case $1 in
    #add an email address for a class
    add-email ) 
        shift
        while getopts ":c:e:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
            e )  email=$OPTARG ;;
           esac
        done
    
        bash ../email-submission.sh add-email -c "$class" -e "$email"
        ;;        

    #submit files for an assignment
    submit )
        shift
        while getopts ":a:c:" opt; do
           case $opt in
           a )  assignment=$OPTARG ;;
           c )  class=$OPTARG ;;
           f )  if [[ (-z "$assignment") ]] ; then
                echo "files must be specified last"
                exit
            fi;
            files="list"
           esac
        done

        #ensure required input was supplied
        if [[ (-z "$assignment") ]] || [[ (-z "$class") ]] ; then
            echo "assignment and class are required to submit an assignment directory"
            exit
        fi;

        bash ../email-submission.sh submit -c "$class" -a "$assignment"
        ;; 

    #create class folder 
    create-class ) 
            shift
            while getopts ":c:" opt; do
               case $opt in
               c )  class=$OPTARG ;;
               esac
            done
            #check if course exists
            
            source ../todo.sh
            create_course "$class";;

    #delete a class folder
    delete-class ) 
        shift
        while getopts ":c:" opt; do
           case $opt in
           c )  class=$OPTARG ;;
           esac
        done
        #check if course exists
        source ../todo.sh
        delete_course "$class";;

    #create an assignment for a class
    create-assignment )
        shift
        while getopts ":a:c:d:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
            a )  assignment=$OPTARG ;;
            d )  due=$OPTARG ;;
           esac
        done
        source ../todo.sh
        create_assignment "$class" "$assignment" "$due";;
    
    #update an existing assignments due date
    update-assignment-due-date) 
        shift
        while getopts ":a:c:d:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
            a )  assignment=$OPTARG ;;
            d )  due=$OPTARG ;;
           esac
        done
        source ../todo.sh
        update_assignment_date "$class" "$assignment" "$due";;

    #delete an existing assignment for a class
    delete-assignment) 
        shift
        while getopts ":a:c:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
            a )  assignment=$OPTARG ;;
           esac
        done
        source ../todo.sh
        delete_assignment "$class" "$assignment" ;;

    #list all the classes for the current semester
    list-classes)
        source ../todo.sh
        list_courses;;

    #list all assignments for the current semester
    list-assignments)
        source ../todo.sh
        list_assignments  ;;
    
    #list all assignments for a specific class
    list-class-assignments)
        shift
        while getopts ":c:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
           esac
        done
        source ../todo.sh
        list_assignments "$class"  ;;

    #List files for a specific assignment
    list-files)
        shift
        while getopts ":c:a:" opt; do
           case $opt in
            c )  class=$OPTARG ;;
            a ) assignment=$OPTARG;; 
           esac
        done
        source ../todo.sh
        list_files_for_assignment "$class" "$assignment"  ;;
    * ) echo "Unknown command";;
esac

