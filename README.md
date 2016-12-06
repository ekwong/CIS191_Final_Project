# CIS191_Final_Project

We created a coursework/organization system that will increase productivity when using a computer. There are many small tasks that detract from efficiency when working - especially in college. The general approach to our project considers a few of these smaller unproductive tasks that could be automated/improved and amalgamates all of them into a single program that has multiple functions. It should be considered as a general course management tool that encompasses tasks from start to submission of assignments, management of course materials and tools to simplify interaction of these course materials.


## Components:

- To do list: It has reminders for course related tasks - HWs, exams, presentations. This will allow for increased efficiency when working since reminders are linked directly to folders so all the work ‘to do’ will be available to you from one place.

- Add a course to your semester

  ```
  cis191-final-project create-class -c cis191
  ```

- Remove a course

  ```
  cis191-final-project delete-class -c cis191
  ```

- List all your courses

  ```
  cis191-final-project list-classes
  ```

- Create assignment for a class (Note assignments can only be created in semester folder)
  ```
  cis191-final-project create-assignment -c cis191 -a hw8 -d 12/16/16
  ```
  
- Update assignment for a class

  ```
  cis191-final-project create-assignment -c cis191 -a hw8 -d 12/16/16
  ```
  
- Delete assignment for a class

  ```
  cis191-final-project delete-assignment -c cis191 -a hw8
  ```
  
- Add TA/Instructors email address
  ```
  cis191-final-project add-email -c cis191 -e ta@course.com
  ```
  
 - Submit an assignment
  ```
  cis191-final-project submit -c cis191 -a hw8
  ```
  
- List assignments (Leave out the -c parameter for all assignments accross all classes)
  ```
  cis191-final-project list-assignments -c cis191 
  ```

- Organization commands: Nowadays, all coursework is available online to download to one's local machine however what ends up happening with these downloaded files is that they stay in the downloads folder - cluttering it up with files from different courses. An organizer will allow for a single command to move all homework files to their respective homework folder in their course folder and sort files by class as well as relation to class e.g. homework/notes/coursework. 

- Email Submission: Many classes require assignments to be submitted to a TA or professor over email. Opening up a browser, attaching files and typing up a body can all be automated into a single command that submits your files to your professor without ever having to open up your email client. 
