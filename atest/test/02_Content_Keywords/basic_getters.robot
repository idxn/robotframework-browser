*** Settings ***
Resource          imports.resource
Suite Setup       New Page    ${LOGIN_URL}

*** Variables ***
${UserNameLabel}=    label[for="username_field"]
${InputUsername}=    ${UserNameLabel} >> //.. >> input

*** Test Cases ***
Get Text
    ${h1}=    Get Text    h1
    Should Be Equal    ${h1}    Login Page

Get Text and Assert ==
    Get Text    ${UserNameLabel}    ==    User Name:

Get Text and Assert !=
    Get Text    ${UserNameLabel}    !=

Get Text Assert Validate
    Get Text    h1    validate    value.startswith('Login')

Get Text With Nonmatching Selector
    [Setup]    Set Timeout    50ms
    Run Keyword And Expect Error    Could not find element with selector `notamatch` within timeout.    Get Text    notamatch
    [Teardown]    Set Timeout    ${PLAYWRIGHT_TIMEOUT}

Get Attribute and Assert
    Get Attribute    h1    innerText    ==    Login Page

Get Attribute innerText
    ${inner_text}=    Get Attribute    ${UserNameLabel}    innerText
    Should Be Equal    ${inner_text}    User Name:

Get Attribute size
    ${size}=    Get Attribute    ${InputUsername}    type
    Should Be Equal    ${size}    text

Get Attribute and Then .. (Closure)
    ${text}=    Get Attribute    h1    innerText    then    value.replace('g', 'k')
    Should be equal    ${text}    Lokin Pake

Get Attribute With Nonmatching Selector
    [Setup]    Set Timeout    50ms
    Run Keyword And Expect Error    Could not find element with selector `notamatch` within timeout.    Get Attribute    notamatch    attributeName
    [Teardown]    Set Timeout    ${PLAYWRIGHT_TIMEOUT}

Get Element Count
    ${count}=    Get Element Count    h1
    Should Be Equal    ${count}    ${1}
    ${count}=    Get Element Count    label
    Should Be Equal    ${count}    ${2}
    ${count}=    Get Element Count    not-existing
    Should Be Equal    ${count}    ${0}

Get Element Count and Assert
    Get Element Count    h1    ==    1
    Get Element Count    h1    ==    ${1}
    Get Element Count    label    validate    value == 2
    Get Element Count    label    >    1
    Get Element Count    not-existing    ==
    ${promise}=    Promise to    Get Element Count    label
    ${count}=    Wait for    ${promise}
    should be equal    ${count}    ${2}

Get Style and Assert
    Get Style    h1    ALL    *=    align-content
    Get Style    h1    align-content    ==    normal
