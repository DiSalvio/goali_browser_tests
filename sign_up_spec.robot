*** Settings ***
Library   SeleniumLibrary
Library   FakerLibrary 
 
 
*** Variables ***
${URL}                            https://benevolent-pegasus-249129.netlify.app/
${SIGN_UP_URL}                    https://benevolent-pegasus-249129.netlify.app/signup
${BROWSER}                        HeadlessChrome
${WAIT_TIME_IN_SECONDS}           10
 
*** Test Cases ***
Test Navigate to Sign Up Page from Login Page
  Set Selenium Implicit Wait      ${WAIT_TIME_IN_SECONDS}
  Open Browser                    ${URL}  ${BROWSER}
  Wait Until Element Is Visible   id:sign-up-link
  Click Element                   id:sign-up-link
  Wait Until Element Is Visible   id:sign-up-header
  Page Should Contain Element     id:sign-up-header
  Close Browser

Test Sign Up Successful
  Open Browser                    ${SIGN_UP_URL}  ${BROWSER}
  ${FAKE_EMAIL}=                  FakerLibrary.Email
  ${FAKE_USERNAME}=               FakerLibrary.User_Name
  ${FAKE_FIRST_NAME}=             FakerLibrary.First_Name
  ${FAKE_LAST_NAME}=              FakerLibrary.Last_Name
  ${FAKE_PASSWORD}=               FakerLibrary.Password

  Wait Until Element Is Visible   id:sign-up-header
  
  Input Text                    id:email                ${FAKE_EMAIL}
  Input Text                    id:username             ${FAKE_USERNAME}
  Input Text                    id:first-name           ${FAKE_FIRST_NAME}
  Input Text                    id:last-name            ${FAKE_LAST_NAME}
  Input Password                id:password             ${FAKE_PASSWORD}
  Input Password                id:confirm-password     ${FAKE_PASSWORD}
  Click Element                 id:sign-up-button

  Wait Until Element Is Visible   id:login-header
  Page Should Contain Element     id:login-header
  Wait Until Element Is Visible   id:sign-up-success
  Page Should Contain Element     id:sign-up-success
  ${SUCCESS_TEXT}=                Get Text          id:sign-up-success
  Should Be Equal                 ${SUCCESS_TEXT}   Sign up successful, Log in now

  Close Browser

Test Navigate to Log In Page from Sign Up Page
  Set Selenium Implicit Wait      ${WAIT_TIME_IN_SECONDS}
  Open Browser                    ${SIGN_UP_URL}  ${BROWSER}
  Wait Until Element Is Visible   id:login-page-link
  Click Element                   id:login-page-link
  Wait Until Element Is Visible   id:login-header
  Page Should Contain Element     id:login-header
  Close Browser
