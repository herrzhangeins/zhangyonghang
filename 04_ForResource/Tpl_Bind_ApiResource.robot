*** Settings ***
Library           ApiTesterLib.src.library.ApiTestLib    ZQBIND
Library           BuiltIn
Resource          Base_Bind_ApiResource.robot
Resource          SZ_Resource.robot

*** Keywords ***
RF_Bind_template_req
    [Arguments]    ${Req}    ${Struct}    ${ApiID}    ${ReqRequestID}    ${Department}    ${BindUserID}
    ...    ${AccountType}    &{kwargs}
    #call api    CreateApiSession    ${ApiID}    ${Department}    ${BindUserID}    ${AccountType}
    #call api    SubscribePrivateTopic    ${ApiID}    ${2}    ${Department}    ${BindUserID}    ${AccountType}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    ${struct}    get struct    ${Struct}    &{kwargs}
    ${return}=    call api    ${Req}    ${ApiID}    ${struct}    ${0}    ${Department}
    ...    ${BindUserID}    ${AccountType}
    [Return]    ${return}

RF_Bind_template_check_rtn
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    &{kwargs}
    &{dict}    Create Dictionary    &{kwargs}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRtnStruct=&{dict}    DepartmentID=${DepartmentID}
    ...    LogInAccount=${LogInAccount}    LogInAccountType=${LogInAccountType}
    ${ret}    set variable    ${list[0]['pRtnStruct']}
    [Return]    ${ret}

RF_Bind_template_check_rsp
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    ${ErrorID}=${0}    &{kwargs}
    &{dict}    Create Dictionary    &{kwargs}
    &{rspinfo}    Create Dictionary    ErrorID=${ErrorID}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspStruct=&{dict}    pRspInfo=&{rspinfo}
    ...    DepartmentID=${DepartmentID}    LogInAccount=${LogInAccount}    LogInAccountType=${LogInAccountType}
    ${ret}    set variable    ${list[0]['pRspStruct']}
    [Return]    ${ret}

RF_Bind_template_check_qry
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    &{kwargs}
    ${ret}    RF_Bind_template_check_rsp    ${FuncName}    ${ApiID}    ${0}    &{kwargs}
    [Return]    ${ret}

RF_Bind_template_check_err
    [Arguments]    ${FuncName}    ${ErrorID}    ${ApiID}=${ApiID}    &{kwargs}
    &{dict}    Create Dictionary    &{kwargs}
    &{rspinfo}    Create Dictionary    ErrorID=${ErrorID}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspInfo=&{rspinfo}    DepartmentID=${DepartmentID}
    ...    LogInAccount=${LogInAccount}    LogInAccountType=${LogInAccountType}
    ${ret}    set variable    ${list[0]['pRtnStruct']}

RF_Bind_template_check_last
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}
    &{rspinfo}    Create Dictionary    ErrorID=${0}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspInfo=&{rspinfo}    DepartmentID=${DepartmentID}
    ...    LogInAccount=${LogInAccount}    LogInAccountType=${LogInAccountType}
    &{ret}    ${list[0]}
    [Return]    ${ret}
