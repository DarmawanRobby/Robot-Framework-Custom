*** Settings ***
Resource    ../resources/GetData.robot


*** Variables ***
${SHEET_NAMES}      Data_1

*** Keywords ***
GET DATA TEST 1
    [Arguments]    ${DESKRIPSI}    ${TCID}
    ${DATA}    CALL DATA    ${DESKRIPSI}    ${TCID}    ${SHEET_NAMES}
    Log  ${DATA}

    # SET DATA TO VARIABLE
    ${TESTID}      Set Variable     ${DATA['TEST ID']}
    ${DESKRIPSI}    Set Variable    ${DATA['DESKRIPSI']}
    ${NAME}         Set Variable    ${DATA['NAME']}
    ${AGE}          Set Variable    ${DATA['AGE']}
    ${ADDRESS}      Set Variable    ${DATA['ADDRESS']}

