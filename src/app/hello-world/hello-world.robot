*** Settings ***
Library    SeleniumLibrary


*** Variables ***


*** Keywords ***


*** Test Cases ***
Hello world
    Open Browser                  about:blank                                                                                  chrome
    Maximize Browser Window
    go to                         https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#library-documentation-top
    Set Selenium Implicit Wait    5
    Close Browser 