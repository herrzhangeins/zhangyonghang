*** Settings ***
Library           BuiltIn
Library           ApiTesterLib.src.library.ApiTestLib    ZQ

*** Variables ***

*** Keywords ***
RF_template_req
    [Arguments]    ${Req}    ${Struct}    ${ApiID}    ${ReqRequestID}    &{kwargs}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    ${struct}    get struct    ${Struct}    &{kwargs}
    ${return}=    call api    ${Req}    ${ApiID}    ${struct}    ${ReqRequestID}
    [Return]    ${return}

RF_template_check_rtn
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    &{kwargs}
    &{dict}    Create Dictionary    &{kwargs}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRtnStruct=&{dict}
    ${ret}    set variable    ${list[0]['pRtnStruct']}
    [Return]    ${ret}

RF_template_check_rsp
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    ${ErrorID}=${0}    &{kwargs}
    [Documentation]    验证响应
    ...
    ...    用于req的正确和错误验证
    ...    以及reqQry的错误验证
    &{dict}    Create Dictionary    &{kwargs}
    &{rspinfo}    Create Dictionary    ErrorID=${ErrorID}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspStruct=&{dict}    pRspInfo=&{rspinfo}
    ${ret}    set variable    ${list[0]['pRspStruct']}
    [Return]    ${ret}

RF_template_check_qry
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    &{kwargs}
    [Documentation]    查询模板
    ...
    ...    验证正确的查询记录
    ...
    ...    注意：验证查询错误时，请使用RF_template_check_rsp
    ${ret}    RF_template_check_rsp    ${FuncName}    ${ApiID}    ${0}    &{kwargs}
    [Return]    ${ret}

RF_template_check_err
    [Arguments]    ${FuncName}    ${ErrorID}    ${ApiID}=${ApiID}    &{kwargs}
    &{dict}    Create Dictionary    &{kwargs}
    &{rspinfo}    Create Dictionary    ErrorID=${ErrorID}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspInfo=&{rspinfo}
    ${ret}    set variable    ${list[0]['pRtnStruct']}

RF_template_check_last
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}
    &{rspinfo}    Create Dictionary    ErrorID=${0}
    ${list}    check call back    ${FuncName}    ${ApiID}    ${max_seq}    pRspInfo=&{rspinfo}    bIsLast=${1}
    &{ret}    ${list[0]}
    [Return]    ${ret}
