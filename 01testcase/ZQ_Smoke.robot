*** Settings ***
Suite Setup
Library           ApiTesterLib.src.library.ApiTestLib    ZQ
Resource          ../02resource/Manage_Resource.robot
Resource          ../02resource/Test_Resource.robot
Resource          ../02resource/SZ_ENV_variable.robot
Resource          ../02resource/BASE_ENV.robot

*** Variables ***
${SessionID}      default
${UserID}         admin    # 5641452
${Password}       123456    # *Sh//+)$
${InvestorID}     5641452
${AccountID}      10044527
${ShareHolderID}    0107670626
${ErrorID}        ${0}
${Volume}         ${100}
${BusinessUnitID}    ${InvestorID}
${DepartmentID}    5108

*** Test Cases ***
00_connect_nameserver
    #Base_connect_nameserver
    Base_connect

01_ReqUserLogin
    [Setup]
    Base_ReqUserLogin    ${UserID}
    #Base_ReqUserLogin    ${AccountID}    1

02_ReqOrderInsert
    [Tags]
    [Setup]
    Base_ReqOrderInsert    ${SecurityID}    ${Price}    ${Volume}

03_ReqOrderAction
    [Tags]    failed
    [Setup]
    Base_ReqOrderAction    ${SecurityID}

04_ReqTransferFund
    [Documentation]    no rsp
    [Tags]
    [Setup]
    Base_ReqTransferFund    ${0.01}    1    00000001

05_ReqDesignationRegistration
    [Tags]
    [Setup]
    Base_ReqDesignationRegistration    ${UserID}    B880304814    10028790    }
    Base_ReqDesignationRegistration    ${UserID}    B880304814    10028790    {

06_ReqForceUserLogout
    Base_ReqForceUserLogout    ${InvestorID}

07_ReqForceUserExit
    Base_ReqForceUserExit    ${InvestorID}

08_ReqUserPasswordUpdate
    Base_ReqUserPasswordUpdate    ${UserID}    ${Password}    123456

09_ReqActivateUser
    Base_ReqActivateUser    ${InvestorID}

10_ReqVerifyUserPassword
    Base_ReqVerifyUserPassword    ${UserID}    ${Password}

11_ReqUserLogout
    Base_ReqUserLogout    ${UserID}

*** Keywords ***
