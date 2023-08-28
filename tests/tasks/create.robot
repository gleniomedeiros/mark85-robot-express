*** Settings ***
Documentation        Cenários de cadastro de tarefas

Resource        ../../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]        critical

    ${data}    Get fixtures    tasks    create

    Reset user from database    ${data}[user]

    Do logi    ${data}[user]

    Go to task form
    Submit task form             ${data}[task]
    Task Should be registered    ${data}[task][name]
    
    Sleep    5

Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup

    ${data}    Get fixtures    tasks    duplicate

    #Dado que eu tenho um novo usuário
    Reset user from database    ${data}[user]

    #E que esse usuário já cadastrou em tarefa 
    
    Create a new task from API    ${data}

    # E que estou logado na aplicação web

    Do logi    ${data}[user]

   #Quando tento cadastrar essa tarefa que já foi cadastrada

    Go to task form
    Submit task form             ${data}[task]

    #Então devo ver uma notificação de deplicidade

    Notice Should be    Oops! Tarefa duplicada.
    Sleep    5

Não deve cadratrar uma novo tarefa quando atinge o limite de tags

    [Tags]        tags_limit

    ${data}    Get fixtures    tasks    tags_limit

    Reset user from database    ${data}[user]
    
    Create a new task from API    ${data}

    Do logi    ${data}[user]

    Go to task form
    Submit task form             ${data}[task]

    Notice Should be    Oops! Limite de tags atingido.
