#!/bin/sh
#parse first command and push to relevant case statement
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

        #only continues if a valid semester folder is present
        if [[ "$foundInitFile" == "true" ]]; then
            #update email address
            echo "emailAddress $email" > .init
        else
            echo "no class folder was found"
            exit
        fi
       
        echo "Email address has been updated";;
    # submit your files for each different assignment
    submit )
        shift

        #iterate through incoming arguments and 
        #assign required variables based on flags
        while getopts ":a:c:" opt; do
           case $opt in
           a )  assignment=$OPTARG ;;
           c )  class=$OPTARG ;;
           esac
        done
      
        cd "$class"
        #ensure command is being executed in a valid class 
        foundInitFile=false
        while [[ "$PWD" != "/" ]] ; do

            pwd
            if [[ -f ".init" ]]; then
                foundInitFile=true
                break
            fi
            cd ..
        done
        #only continues if a valid semester folder is present
        if [[ "$foundInitFile" == "true" ]]; then
            #get valid email address
            while read line; do
               emailAddress=${line:13}
          
            done < ".init"
        else
            echo "no class folder was found"
            exit
        fi

      
        #change directory to folder with files to submit
        cd "assignments" 
        cd "$assignment"
        rm -f files.tar   
        # create tar file
        tar -cf files.tar "../$assignment"
        #send tar file
        echo "Please find my homework files attached!" | mutt -a files.tar -s "Homework files" -- < /dev/null  "$emailAddress"
        echo "Files have been submitted"
        #remove tar file
        rm -f files.tar
        ;;

    * ) echo "Unknown command";;
esac
shift
