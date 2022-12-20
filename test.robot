
*** Variables ***

${HOSTNAME}             127.0.0.1
${PORT}                 55001
${SERVER}               http://${HOSTNAME}:${PORT}
${LOGIN}		http://${HOSTNAME}:${PORT}/accounts/login
${BROWSER}              chrome
${USERNAME}             demo_user
${PASSWORD}             qwer0987!


*** Settings ***

Documentation   Django Robot Tests
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library		Dialogs
Library         DjangoLibrary  ${HOSTNAME}  ${PORT}  manage=manage.py  settings=mysite.settings  db=db.sqlite3
Library		mysite/lib/NewUserLib.py
Suite Setup     Start Django and open Browser
Suite Teardown  Stop Django and close Browser


*** Keywords ***

Start Django and open Browser
  Start Django
  Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
  Close Browser
  Stop Django

Input Username 
  [Arguments]  ${username}
  Input Text  id_username  ${username}

Input Password 
  [Arguments]  ${password}
  Input Text  id_password  ${password}

Submit Credentials
  Click Button  id_submit_login


*** Test Cases ***

Test Page
	  [Tags]  Basic
          Go To  ${SERVER}
          Page Should Contain  Ultra cool blog

Test ShowUser
	  [Tags]  User  
	  Create Superuser  demo  demo@test.com  password
	  show_users


Test SuperUser login
	  [Tags]  User  wip  
	  Create Superuser  ${USERNAME}  demo@test.com  ${PASSWORD}
	  Go To  ${SERVER}/admin
	  Wait until page contains  Django administration
	  # Evaluate    pdb.Pdb(stdout=sys.__stdout__).set_trace()    modules=sys, pdb
	  Input Username  ${USERNAME}
	  Input Password  ${PASSWORD}
	  Wait until page contains  Django administration
	  Click Button  Log in
	  Page should not contain  Please enter the correct username and password


Test User login
	  [Tags]  User
	  As a visitor I can log in
	  Create User  demo  demo@test.com  password  
	  Go to  ${SERVER}
          Click Link  id=id_login_button
	  Input Username  demo	
	  Input Password  password
	  Submit Credentials	 
	  Page Should Contain  Log out

Test login 
	  [Tags]  Login
	  As a visitor I can try to log
          Go to  ${SERVER}
          Click Link  id=id_login_button
          Input Username  demo  
          Input Password  password
          Submit Credentials    
          Page Should Not Contain  Log out
 
