*** Settings ***
Documentation        Cenários de tentativa de cadastro com senha muito curta   

Resource        ../resources/base.resource
Test Template    Short password

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Não deve logar com senha de 1 digito    1
Não deve logar com senha de 2 digitos    2
Não deve logar com senha de 3 digitos    123
Não deve logar com senha de 4 digitos    1234
Não deve logar com senha de 5 digito    12345





#*** Keywords ***
#Short password
 #   [Arguments]        ${short_pass}

  #  ${user}    Create Dictionary
   #...    name=Teste
   #...    email=teste1@gmail.com
   #...    password=${short_pass}

    #Go to signup page
    #Submit signup from    ${user}

    #Alert Should be        Informe uma senha com pelo menos 6 digitos