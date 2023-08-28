*** Settings ***
Documentation        Cenários de teste de atualização de tarefas 

Resource    ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot  

*** Test Cases ***

Deve poder marcar uma tarefa como concluida

    ${data}        Get fixtures    tasks    done

    Reset user from database    ${data}[user]

    Create a new task from API    ${data}

    Do logi    ${data}[user]

    Mark task as completed    ${data}[task][name]
    Task Should be complete   ${data}[task][name]

    Sleep    5