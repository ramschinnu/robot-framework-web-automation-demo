*** Setting ***
Resource   ../object-repository/page-objects/LoginPo.robot
Resource    ../configs/ApplicationVariables.robot

Documentation   This suite includes login tests

Test Teardown  Close Browser


*** Variables ***
${invalidUserName}                       osa
${invalidPassword}                       test@12
${WRONG_PASSWORD_ERROR_MESSAGE}          Wrong password.
${USER_DOES_NOT_EXIST_ERROR_MESSAGE}     User does not exist.


*** Test Cases ***
Verify That An Unregistered Person Cannot Login To The Application
    [Documentation]    TVerify that an unregistered person cannot login to the application
    [Tags]  Regression
    Open Browser To Login Page
    sleep    10
    Login To The Application     ${invalidUserName}     ${invalidPassword}
#          ${USER_DOES_NOT_EXIST_ERROR_MESSAGE}
    sleep    3
    ${alert_present}=    Run Keyword And Return Status    Alert Should Be Present
    sleep    3
    log to console    status::${alert_present}
    IF    '${alert_present}' == "True"
        log to console    we got error
    END
#    set selenium implicit wait    40
#    Alert Should Be Present    User does not exist.
#    handle alert    leave
#    sleep    5
#    log to console    yesss
#    handle alert    accept
#    log to console    yes
#    Should Be Equal    ${alert_text}    wrong password
#    Accept Alert


Verify That A Registered User Cannot Login To The Application Using An Incorrect Password
    [Documentation]    Verify that a registered user cannot login to the application using an incorrect password
    [Tags]  Regression

    Open Browser To Login Page
    Submit Login Information [Arguments] ${USERNAME} ${invalidPassword}
    User Should See An Alert With The Error Message [Arguments] ${WRONG_PASSWORD_ERROR_MESSAGE}


Verify That A Registered User Can Login To The Application Using The Correct Password
    [Documentation]    Verify that a registered user can login to the application using the correct password
    [Tags]  Smoke
    Open Browser To Login Page
    Login To The Application     ${USERNAME}        ${PASSWORD}
    sleep    10
    Logout From The Application
    sleep   10