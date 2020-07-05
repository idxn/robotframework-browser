*** Settings ***
Resource          imports.resource
Suite Setup       Go To    ${FORM_URL}
Test Timeout      10s

*** Keywords ***
Select Option And Verify Selection
    [Arguments]    ${attribute}    ${list_id}    @{selection}
    Select Options By    ${attribute}    ${list_id}    @{selection}
    Get Selected Options    ${list_id}    ${attribute}    ==    @{selection}

*** Test Cases ***
Page Should Contain List
    Page Should Have    select[name=interests]

Get Selected Options
    [Documentation]
    ...    Verifying list 'preferred_channel' has options [Telephone] selected.
    ...    Verifying list 'possible_channels' has options [ Email | Telephone ] selected.
    ...    Verifying list 'interests' has no options selected.
    ...    Verifying list 'possible_channels' fails if assert all options selected.
    ${selection}=    Get Selected Options    select[name=preferred_channel]    label    ==    Telephone
    Log    ${selection}
    Should Be Equal    ${selection}    Telephone
    Get Selected Options    select[name=preferred_channel]    value    ==    phone
    Get Selected Options    select[name=possible_channels]    text    ==    Email    Telephone
    Get Selected Options    select[name=possible_channels]    label    ==    Telephone    Email
    ${selection}=    Get Selected Options    select[name=possible_channels]    value    ==    phone    email
    Should Be Equal    ${selection}[0]    email
    Should Be Equal    ${selection}[1]    phone
    Get Selected Options    select[name=interests]    label    ==
    ${selection}=    Get Selected Options    select[name=interests]    label    ==
    Should Be Equal    ${selection}    ${None}
    Run Keyword And Expect Error    *
    ...    Get Selected Options    select[name=possible_channels]    label    ==    Email    Telephone    Direct mail

Select Option By label
    Select Option And Verify Selection    label    select[name=preferred_channel]    Direct mail

Select Options By value
    Select Option And Verify Selection    value    select[name=interests]    males    females    others

Select Options By index
    Select Option And Verify Selection    index    select[name=possible_channels]    0    2

Select Options By text
    Select Option And Verify Selection    text    select[name=interests]    Males    Females

Deselect Options
    Select Option And Verify Selection    text    select[name=possible_channels]