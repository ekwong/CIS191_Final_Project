case $1 in

        #Part 1 - Creates a directory 
        -e)

             #Parse email data here
        touch emails.txt
        > emails.txt
        grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" tempInput.txt > emails.txt
        sed -i -e 's/@/ (at) /g' emails.txt
        sed -i -e 's/\./ (dot) /g' emails.txt



        # Part 2 - adding files to be backed up
        -a)

                #Parse attatchments here
        -c) #Parse contact list here

setupData (){

        if [[ "$email" == true ]]; then
                
        fi

        if [[ "$attatchments" == true ]]; then
               
        fi

        if [[ "$send" == true ]]; then
                crawlURLS $1
        fi





}
