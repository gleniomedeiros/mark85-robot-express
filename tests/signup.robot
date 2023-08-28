*** Settings ***
Documentation

Resource        ../resources/base.resource

#Suite Setup       Log    Tudo aqui ocerre antes da Suite ( antes de todos os testes)
#Suite Teardown    Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)

Test Setup       Start Session
Test Teardown    Take Screenshot
Library    Collections

*** Test Cases ***
Deve poder cadratrar um novo usuário

    ${user}        Create Dictionary    
    ...    name=Glenio Medeiros    
    ...    email=glenio28@hotmail.com    
    ...    password=@Matheus1728

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup from    ${user}
    Notice Should be      Boas vindas ao Mark85, o seu gerenciador de tarefas.



Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}    Create Dictionary    
    ...    name=Glenio Nunes    
    ...    email=glenio21nunes@gmail.com    
    ...    password=@Matheus1728
        
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go to signup page
    Submit signup from    ${user}
    Notice Should be      Oops! Já existe uma conta com o e-mail informado.

Campos obrigatorios
    [Tags]    required

   ${user}    Create Dictionary
   ...    name=${EMPTY}
   ...    email=${EMPTY}
   ...    password=${EMPTY}

    Go to signup page
    Submit signup from    ${user}

    Alert Should be        Informe seu nome completo
    Alert Should be        Informe seu e-email
    Alert Should be        Informe uma senha com pelo menos 6 digitos
Não deve cadrastrar com email incorreto
    [Tags]    inv_email

    ${user}    Create Dictionary
    ...    name= Glenio Medeiros
    ...    email=glenio.com.br
    ...    password=1234567
    
    Go to signup page
    Submit signup from    ${user}
    Alert Should be    Digite um e-mail válido

Não deve cadrastrar com senha muito curta
    [Tags]    temp

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}

       ${user}    Create Dictionary
       ...    name=Teste
       ...    email=teste1@gmail.com
       ...    password=${password}

        Go to signup page
        Submit signup from    ${user}

        Alert Should be        Informe uma senha com pelo menos 6 digitos
        
    END

#*** Keywords ***
#Short password
#    [Arguments]        ${short_pass}

#    ${user}    Create Dictionary
#   ...    name=Teste
 #  ...    email=teste1@gmail.com
  # ...    password=${short_pass}

   # Go to signup page
    #Submit signup from    ${user}

    #Alert Should be        Informe uma senha com pelo menos 6 digitos
