*** Settings ***
Documentation        Cenários de teste de remoção de tarefas 

Resource    ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot  

*** Test Cases ***

Deve poder apagar uma tarefa indesejada

    ${data}        Get fixtures    tasks    delete

    Reset user from database    ${data}[user]

    Create a new task from API    ${data}

    Do logi    ${data}[user]

    Request removal          ${data}[task][name]
    Task Should not exist    ${data}[task][name]

    Sleep    5