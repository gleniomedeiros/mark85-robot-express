*** Settings ***

Library    libs/database.py
Library    Browser
Library    JSONLibrary

Resource    env.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Header.resource
Resource    pages/components/Alert.resource
Resource    pages/TasksPage.resource
Resource    pages/SignupPage.resource
Resource    pages/loginPage.resource
Resource    pages/TaskCreatePage.robot
Resource    services.resource


*** Variables ***


*** Keywords ***
Start Session
     New Browser     browser=${BROWSER}    headless=False
     New Page        ${BASE_URL}

Short password
    [Arguments]        ${short_pass}

    ${user}    Create Dictionary
   ...    name=Teste
   ...    email=teste1@gmail.com
   ...    password=${short_pass}

    Go to signup page
    Submit signup from    ${user}

    Alert Should be        Informe uma senha com pelo menos 6 digitos     

#Helpers
Get fixtures
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    [Return]    ${data}[${scenario}]

Reset user from database 

    [Arguments]        ${user}

    Clean user from database     ${user}[email]
    Insert user from database    ${user}  

Create a new task from API
    [Arguments]        ${data}

    POST user session    ${data}[user]
    POST a new task      ${data}[task]

Do logi
    [Arguments]        ${user}

    Submit login form            ${user}
    User Should be logged in     ${user}[name]