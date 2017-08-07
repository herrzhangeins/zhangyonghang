*** Settings ***
Documentation     业务关键字
Resource          ../02resource/Base_ApiResource.robot
Library           BuiltIn
Resource          ../02resource/Base_ApiQryResource.robot

*** Variables ***
${ApiID}          default
${Password}       123456
${RequestID}      ${0}
${CurrencyID}     CNY

*** Keywords ***
Base_ReqForceUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqForceUserLogout    ${UserID}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspForceUserLogout    ${ApiID}    UserID=${UserID}

Base_ReqForceUserExit
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqForceUserExit    ${UserID}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspForceUserExit    ${ApiID}    UserID=${UserID}

Base_ReqUserPasswordUpdate
    [Arguments]    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}=${ApiID}
    RF_ReqUserPasswordUpdate    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspUserPasswordUpdate    ${ApiID}    UserID=${UserID}    OldPassword=******    NewPassword=******

Base_ReqActivateUser
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqActivateUser    ${UserID}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspActivateUser    ${ApiID}    UserID=${UserID}

Base_ReqVerifyUserPassword
    [Arguments]    ${UserID}    ${Password}    ${ApiID}=${ApiID}
    RF_ReqVerifyUserPassword    ${UserID}    ${Password}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspVerifyUserPassword    ${ApiID}    UserID=${UserID}    Password=******

Base_ReqTransferFund
    [Arguments]    ${Amount}    ${TransferDirection}    ${ApplySerial}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_ReqTransferFund    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnTransferFund    ${ApiID}    AccountID=${AccountID}    TransferDirection=${TransferDirection}    Amount=${Amount}
    ...    TransferStatus=1    ApplySerial=${ApplySerial}
    [Return]    ${ret}

Base_ReqTransferPostion
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}=${ApiID}
    RF_ReqTransferPosition    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnTransferPosition    ${ApiID}    ShareholderID=${ShareholderID}    SecurityID=${SecurityID}    TransferStatus=1
