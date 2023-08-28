*** Settings ***
Documentation        Cenários de autenticação do usuário

Library     Collections
Resource    ../resources/base.resource
Resource    ../resources/pages/components/Notice.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    ${user}    Create Dictionary
    ...    name=Glenio Medeiros
    ...    email=glenio28@hotmail.com
    ...    password=@Matheus1728
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Submit login form            ${user}
    User Should be logged in     ${user}[name]


Não deve logar com senha inválida

    ${user}    Create Dictionary
    ...    name=Medeiros Glenio
    ...    email=medeiros@hotmail.com
    ...    password=@Matheus1728
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=123
    
    Submit login form           ${user}
    Notice Should be            Ocorreu um erro ao fazer login, verifique suas credenciais.