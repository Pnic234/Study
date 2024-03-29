*** Settings ***
Library               RequestsLibrary

*** Test Cases ***

Quick Get Request Test
    ${response}=    GET  https://www.google.com
    Log To Console    ${response.content}

#Quick Get Request With Parameters Test
#    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#    Log To Console    ${response}
#
#Quick Get A JSON Body Test
#    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#    Log To Console    ${response.json()}[id]
#    Should Be Equal As Strings    1  ${response.json()}[id]