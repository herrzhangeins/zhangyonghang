*** Settings ***
Documentation     业务关键字
Resource          ../02resource/Base_ApiResource.robot
Library           BuiltIn
Resource          ../02resource/Qry_Resource.robot

*** Variables ***
${ApiID}          default
${Password}       123456
${OrderRef}       ${0}
${RequestID}      ${0}
${IPAddress}      192.168.56.1
${MacAddress}     ${EMPTY}
${MD_Port}        9402
${TerminalInfo}    VipTest

*** Keywords ***
Base_ReqUserLogin
    [Arguments]    ${UserID}    ${AccountType}=0    ${ApiID}=${ApiID}    ${Password}=${Password}
    RF_ReqUserLogin    ${UserID}    ${AccountType}    ${Password}    ${ApiID}
    RF_OnRspUserLogin    ${UserID}    \x00    ${ApiID}

Base_ReqUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqUserLogout    ${UserID}    ${ApiID}
    RF_OnFrontDisconnected    ${ApiID}

Base_MD_Connect
    [Arguments]    ${ApiID}=${ApiID}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    create_session    ${ApiID}    ZQMD
    register_front    tcp://${server_ip}:${MD_Port}    ${ApiID}
    connect    ${ApiID}
    check call back    OnFrontConnected    ${ApiID}    ${max_seq}

Base_MD_Connect_nameserver
    [Arguments]    ${ApiID}=${ApiID}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    create_session    ${ApiID}    ZQMD
    register_nameserver    tcp://${server_ip}:${Fens1_MD_Port}    ${ApiID}
    register_nameserver    tcp://${server_ip}:${Fens2_MD_Port}    ${ApiID}
    connect    ${ApiID}
    check call back    OnFrontConnected    ${ApiID}    ${max_seq}    time_out=${30}

Base_SubscribeMarketData
    [Arguments]    ${UserID}    ${AccountType}=0    ${ApiID}=${ApiID}    ${Password}=${Password}
    RF_ReqUserLogin    ${UserID}    ${AccountType}    ${Password}    ${ApiID}
    RF_OnRspUserLogin    ${UserID}    \x00    ${ApiID}
