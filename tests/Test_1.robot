*** Settings ***
Resource    ../func/fungsional_1.robot
Test Template    GET DATA TEST 1
 
*** Test Cases ***
# =================================================================
# TEST CASE                 DESKRIPSI                      TESTID 
# =================================================================
TC001 - GET DATA TESTING    personal information           TC001
TC002 - GET DATA TESTING    personal information fail 1    TC002
TC003 - GET DATA TESTING    personal information fail 2    TC003