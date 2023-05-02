*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary

*** Variable ***
${Browser}  Chrome
${URL}  http://www.google.com

*** Variables ***
${CityName}  Pune

*** Test Cases ***
First Test Case
    Open Browser  ${URL}  ${Browser}
    Maximize Browser Window
    Input Text  xpath://input[@class='gLFyf']  google weather ${Cityname}
    Click Element  xpath:(//*[@value='Google Search'])[2]
    ${info}=  Get Text    xpath=//*[@class="nawv0d"]
    Log To Console    ${\n}${info}
    Close Browser

*** Keywords ***
Weather
    [Arguments]  ${city}
    Set Selenium Speed  3
    ${URL}=  set variable  http://www.google.com/google/weather/${city}
    Open Browser  ${URL}  ${Browser}
    Create Se

