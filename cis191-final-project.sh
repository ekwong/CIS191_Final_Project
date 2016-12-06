#!/bin/sh
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

        echo "init semester command"
        exit;
    ;;    
esac

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


case $1 in
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

        if [[ (-z "$assignment") ]] || [[ (-z "$class") ]] ; then
            echo "assignment and class are required to submit an assignment directory"
            exit
        fi;

        bash ../email-submission.sh submit -c "$class" -a "$assignment"
        ;; 

    * ) echo "Unknown command";;
esac

