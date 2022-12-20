*** Variables ***

${HOSTNAME}             127.0.0.1
${PORT}                 8000
${SERVER}               http://127.0.0.1:8000/
${LOGIN}		http://127.0.0.1:8000/accounts/login
${BROWSER}              chrome


*** Settings ***

Documentation   Django Robot Tests
Library         SeleniumLibrary  timeout=10  implicit_wait=0
Library         DjangoLibrary  ${HOSTNAME}  ${PORT}  path=mysite/mysite  manage=mysite/manage.py  settings=mysite.settings
Suite Setup     Start Django and open Browser
Suite Teardown  Stop Django and close Browser


*** Keywords ***

Start Django and open Browser
  Start Django
  Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
  Close Browser
  Stop Django


*** Test Cases ***

Scenario: As a visitor I can visit the django default page
          Go To  ${SERVER}
          Page Should Contain  Ultra cool blog

Scenario: As a visitor I can try to log
          Go To  ${LOGIN}
          Page Should Contain  Username
          Click Button  login
	 
