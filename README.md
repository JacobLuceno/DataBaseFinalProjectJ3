# DataBaseFinalProjectJ3
Final project


This repo contains the files you'll need to get our app running.

To install, run the two provided sql scripts in mariaDB, first tableCreation.sql, then DemoUserMoods.sql.

Then open the app.js file to configure connection details and port number for the connection.  

Then run npm install in the root directory containing the project.  

Run "node app.js" and by default, the program will be available on localhost:3000.


Changes we made from V1:

All SQL has been replaced by stored procedures, including selects and inserts. 

A view has been added to select the user's moods, and the moods' associated colors and string descriptions, inserted in the last week.

A function has been added which returns a string containing the concatonated values of the mood and color of the most frequent mood in the last week, which is parsed in the JS.

A trigger has been added which monitors new insertions to the mood table, and rejects insertions which happen at a date later than the current date and time.
