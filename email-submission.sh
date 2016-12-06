#!/bin/sh

case $1 in
    #Adds an email address to the current class's store
    add-email )

        shift

        #iterate through incoming arguments and 
        #assign required variables based on flags
        while getopts ":c:e:" opt; do
           case $opt in
           c )  class=$OPTARG ;;
           e )  email=$OPTARG ;;
           esac
        done
        
        #ensure command is being executed in a valid class 
        cd "$class"
        foundInitFile=false
        while [[ "$PWD" != "/" ]] ; do

            
            if [[ -f ".init" ]]; then
                foundInitFile=true
                break
            fi
            cd ..
        done

        if [[ "$foundInitFile" == "true" ]]; then
            echo "emailAddress $email" > .init
        else
            echo "no class folder was found"
            exit
        fi
       
        echo "Email address has been updated";;
    submit )

        shift
        while getopts ":a:c:" opt; do
           case $opt in
           a )  assignment=$OPTARG ;;
           c )  class=$OPTARG ;;
           f )  files="list"
           esac
        done
      
        cd "$class"
       
        foundInitFile=false
        while [[ "$PWD" != "/" ]] ; do

            pwd
            if [[ -f ".init" ]]; then
                foundInitFile=true
                break
            fi
            cd ..
        done

        if [[ "$foundInitFile" == "true" ]]; then
            while read line; do
               emailAddress=${line:13}
          
            done < ".init"
        else
            echo "no class folder was found"
            exit
        fi

      

        cd "Assignments" 
        cd "$assignment"
        rm -f files.tar   
        tar -cf files.tar "../$assignment"
      
        mutt -a files.tar -s "Test Email" -- < /dev/null  "$emailAddress"
        echo "Files have been submitted"
        rm -f files.tar
        ;;

    * ) echo "Unknown command";;
esac
shift



#shift $(($OPTIND - 1))


#echo "the remaining arguments are: $1 $2 $3"

