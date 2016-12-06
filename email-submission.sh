#!/bin/sh


case $1 in
    init ) 
        shift
        while getopts ":c:" opt; do
           case $opt in
           c )  class=$OPTARG ;;
           esac
        done
    
        if [[ (-z "$class") ]] ; then
            echo "class is required to create class directory"
            exit
        fi;
        
        mkdir -p "$class"
        cd "$class"
        mkdir -p Assignments
        mkdir -p Notes
        mkdir -p Administration
        touch .init
        echo "className $class" > .init 
        echo "Initalized class folder for $class"
    ;;
    add-email )

        shift
        while getopts ":e:" opt; do
           case $opt in
           e )  email=$OPTARG ;;
           esac
        done
    
        if [[ (-z "$email") ]] ; then
            echo "email are required to add an email address"
            exit
        fi;
        
        foundInitFile=false
        while [[ "$PWD" != "/" ]] ; do

            
            if [[ -f ".init" ]]; then
                foundInitFile=true
                break
            fi
            cd ..
        done

        if [[ "$foundInitFile" == "true" ]]; then
            echo "emailAddress $email" >> .init
        else
            echo "no class folder was found"
            exit
        fi
       
        echo "Email address has been updated";;
    submit )
        shift
        while getopts ":e:c:" opt; do
           case $opt in
           e )  email=$OPTARG ;;
           c )  class=$OPTARG ;;
           f )  files="list"
           esac
        done
    
        if [[ (-z "$class") ]]  || [[ (-z "$email") ]] ; then
            echo "class and email are required to add an email address"
            exit
        fi;

        foundInitFile=false
        while [[ "$PWD" != "/" ]] ; do

            
            if [[ -f ".init" ]]; then
                foundInitFile=true
                break
            fi
            cd ..
        done

        if [[ "$foundInitFile" == "true" ]]; then
            while read p; do
                echo $p
            done < ".init"
        else
            echo "no class folder was found"
            exit
        fi

      
        echo "shup email and class and files are set";;
    * ) echo "Unknown command";;
esac
shift



shift $(($OPTIND - 1))


#echo "the remaining arguments are: $1 $2 $3"




#-a add-email -e emailAddress -c className
#-a submit -c cis191 -e emailAddress -f [files here]