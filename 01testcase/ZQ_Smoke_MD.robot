*** Settings ***
Suite Setup
Library           ApiTesterLib.src.library.ApiTestLib    ZQMD
Resource          ../02resource/MD_Resource.robot
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
    #Base_MD_Connect
    Base_MD_Connect_nameserver

01_ReqUserLogin
    [Setup]
    Base_ReqUserLogin    ${UserID}    0
    #Base_ReqUserLogin    ${AccountID}    1

02_SubscribeMarketData
    [Tags]
    [Setup]
    RF_SubscribeMarketData    ${ApiID}    600000    600004
    #RF_OnRtnDepthMarketData    600000

03_UnSubscribeMarketData
    [Tags]
    [Setup]
    RF_UnSubscribeMarketData    ${ApiID}    600000    600004
    #RF_OnRtnDepthMarketData    600000

11_ReqUserLogout
    Base_ReqUserLogout    ${UserID}
