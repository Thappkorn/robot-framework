*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}        chrome
${url}            https://uat.potioneer.com/
${email}          jojoe090341@gmail.com
${password}       12345679
${time-render}    2
# helping text
${field-is-required-text}    Please enter the required fields.
${user-is-incorrect-text}    Email address or password is either incorrect or not register with Potioneer
# path
${x-path-popup-sign-in}    xpath=//*[@id="__next"]/div/div[1]/header/div[1]/div/div/div[2]/div[2]
${x-path-popup-profile}    xpath=//*[@id="__next"]/div/div[1]/header/div[1]/div/div/div[2]/div[3]


*** Keywords ***
# component
# common
# action
# event

@open-browser
    Open Browser               about:blank    ${browser}    
    Maximize Browser Window
    go to                      ${url}

@accept-cookie
    Click Button    Accept

@close-all-popup
    Press Keys    None    ESC

@set-time-out-popup-sign-in
    Wait Until Element Is Visible    ${x-path-popup-sign-in}    ${time-render} 

@open-popup-Login
    @close-all-popup
    @set-time-out-popup-sign-in
    Press keys                     ${x-path-popup-sign-in}    ENTER

@logout
    Click Button    Logout

@close-browser-window
    @close-all-popup
    Close Browser


##


*** Test Cases ***
Valid Login
# start browser
    @open-browser
    @accept-cookie
    @close-all-popup
##
    @open-popup-Login
    Input Text                       email                      ${email}
    Input Password                   password                   ${password}
    Click Button                     Log In
    Wait Until Element Is Visible    ${x-path-popup-profile}    ${time-render} 
    Press keys                       ${x-path-popup-profile}    ENTER
    Wait Until Page Contains         ${email}                   ${time-render} 
    Set Selenium Implicit Wait       2
    @logout

Invalid Login with required email
    @open-popup-Login
    Input Password              password                     ${password}
    Click Button                Log In
    Wait Until Page Contains    ${field-is-required-text}    ${time-render} 

Invalid Login with required password
    @open-popup-Login
    Input Text                  email                        ${email}
    Click Button                Log In
    Wait Until Page Contains    ${field-is-required-text}    ${time-render} 

Invalid Login with user is incorrect
    @open-popup-Login
    Input Text                  email                        ${email}
    Input Password              password                     test_user_is_incorrect
    Click Button                Log In
    Wait Until Page Contains    ${user-is-incorrect-text}    ${time-render} 

# end browser
    @close-browser-window
##