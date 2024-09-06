*** Settings ***
Library     ../lib/rby-excel.py
Library     SeleniumLibrary
Library     Collections


*** Variables ***
${excel_file}       ${CURDIR}/../data/Data_Test.xlsx
${SHEET_NAMES}      Data_1, Data_2

*** Keywords ***
CALL DATA
    [Arguments]    ${DESKRIPSI}    ${TCID}    ${SHEET_DATA}=${None}
    ${result}    get_data_by_id_from_sheets
    ...    ${excel_file}
    ...    ${DESKRIPSI}
    ...    ${TCID}
    ...    ${SHEET_NAMES.split(',')}

    IF    ${result} != None 
        Log    Data Found: ${result}
        RETURN    ${result}
    ELSE
        Log To Console    Data Not Found
        RETURN    Data Not Found
    END
    
