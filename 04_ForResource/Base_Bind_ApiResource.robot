*** Settings ***
Library           ApiTesterLib.src.library.ApiTestLib    ZQBIND
Library           BuiltIn
Resource          Tpl_Bind_ApiResource.robot
Resource          Bind_testResource.robot
Resource          MD_Resource.robot

*** Variables ***
${ApiID}          default
${LANG}           zh_cn
${IPAddress}      ${EMPTY}
${MacAddress}     ${EMPTY}
${UserProductInfo}    ${TerminalInfo}
${InterfaceProductInfo}    ${TerminalInfo}
${ProductInfo}    ${TerminalInfo}
${ProtocolInfo}    ${TerminalInfo}
${OnetimePassword}    ${EMPTY}
${ClientIPAddress}    ${IPAddress}
${LogInAccountType}    0
${LogInAccount}    ${UserID}
${BusinessUnitID}    ${InvestorID}
${Operway}        +

*** Keywords ***
Base_Bind_ReqUserLogin
    [Arguments]    ${UserID}    ${AccountType}=0    ${ApiID}=${ApiID}    ${Password}=${Password}
    RF_Bind_ReqUserLogin    ${UserID}    ${AccountType}    ${Password}    5108    ${ApiID}
    RF_Bind_OnRspUserLogin    ${UserID}    ${AccountType}    ${ApiID}

RF_Bind_ReqUserLogin
    [Arguments]    ${LogInAccount}    ${LogInAccountType}    ${Password}    ${DepartmentID}    ${ApiID}=${ApiID}
    call api    CreateApiSession    ${ApiID}    ${DepartmentID}    ${LogInAccount}    ${LogInAccountType}
    call api    SubscribePrivateTopic    ${ApiID}    ${2}    ${DepartmentID}    ${LogInAccount}    ${LogInAccountType}
    ${ret}    RF_Bind_template_req    ReqUserLogin    CTORATstpReqUserLoginField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    LogInAccount=${LogInAccount}    LogInAccountType=${LogInAccountType}    DepartmentID=${DepartmentID}    Password=${Password}
    [Return]    ${ret}

RF_Bind_OnRspUserLogin
    [Arguments]    ${LogInAccount}    ${AccountType}=0    ${ApiID}=${ApiID}    # ${ret}
    ${ret}    RF_Bind_template_check_rsp    OnRspUserLogin    ${ApiID}
    Set Suite Variable    ${sid}    ${ret['SessionID']}
    Set Suite Variable    ${FrontID}    ${ret['FrontID']}

Base_Bind_ReqOrderInsert
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${VolumeTotalOriginal}    ${Direction}=0    ${ApiID}=${ApiID}
    ${OrderPriceType}    set variable    2    #TORA_TSTP_OPT_LimitPrice
    ${CombOffsetFlag}    set variable    0
    ${CombHedgeFlag}    set variable    1
    ${TimeCondition}    set variable    3    #TORA_TSTP_TC_GFD
    ${VolumeCondition}    set variable    1    #TORA_TSTP_VC_AV
    ${MinVolume}    set variable    ${0}
    ${ForceCloseReason}    set variable    6    #TORA_TSTP_FCC_Other
    ${IsAutoSuspend}    set variable    ${0}
    ${RequestID}    set variable    ${0}
    ${UserForceClose}    set variable    ${0}
    ${IsSwapOrder}    set variable    ${0}
    ${CreditPositionType}    set variable    0
    ${OrderStatus}    set variable    3    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    3    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    #${OrderRef}    set variable
    RF_Bind_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_rtn    OnRtnOrder    ${ApiID}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    UserID=${UserID}
    ...    ShareholderID=${ShareholderID}    ExchangeID=${ExchangeID}    VolumeTotalOriginal=${VolumeTotalOriginal}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}    #LimitPrice=${LimitPrice}
    ...    # OrderRef=${OrderRef}

RF_Bind_ReqOrderInsert
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareholderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqOrderInsert    CTORATstpInputOrderField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    OrderRef=${OrderRef}    UserID=${UserID}
    ...    OrderPriceType=${OrderPriceType}    Direction=${Direction}    CombOffsetFlag=${CombOffsetFlag}    CombHedgeFlag=${CombHedgeFlag}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${VolumeTotalOriginal}
    ...    TimeCondition=${TimeCondition}    VolumeCondition=${VolumeCondition}    MinVolume=${MinVolume}    ForceCloseReason=${ForceCloseReason}    RequestID=${RequestID}    TransfereePbuID=123
    ...    UserForceClose=${UserForceClose}    IsSwapOrder=${IsSwapOrder}    ExchangeID=${ExchangeID}    ShareholderID=${ShareholderID}    BusinessUnitID=${BusinessUnitID}    AccountID=${AccountID}
    ...    IPAddress=${IPAddress}    MacAddress=${MacAddress}    CreditPositionType=${CreditPositionType}    Operway=${Operway}
    [Return]    ${ret}

Base_Bind_ReqOrderAction
    [Arguments]    ${SecurityID}    ${SessionID}=${sid}    ${OrderStatus1}=3    ${OrderRef}=${OrderRef}    ${ApiID}=${ApiID}
    #${FrontID}    set variable    ${1}
    ${OrderSysID}    set variable
    ${ActionFlag}    set variable    0
    ${LimitPrice}    set variable    ${0}
    ${VolumeChange}    set variable    ${0}
    ${OrderSubmitStatus1}    set variable    1
    #${OrderSubmitStatus2}    set variable    3
    #${OrderStatus2}    set variable    5
    ${OrderRef}    convert to string    ${OrderRef}
    RF_Bind_ReqOrderAction    ${InvestorID}    \    ${OrderRef}    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    \    \    ${ApiID}
    RF_Bind_template_check_rsp    OnRspOrderAction    ${ApiID}

RF_Bind_ReqOrderAction
    [Arguments]    ${InvestorID}    ${OrderActionRef}    ${OrderRef}    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    ${IPAddress}    ${MacAddress}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqOrderAction    CTORATstpInputOrderActionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    OrderActionRef=${OrderActionRef}    OrderRef=${OrderRef}    RequestID=${RequestID}
    ...    FrontID=${FrontID}    SessionID=${SessionID}    ExchangeID=${ExchangeID}    OrderSysID=${OrderSysID}    ActionFlag=${ActionFlag}    LimitPrice=${LimitPrice}
    ...    VolumeChange=${VolumeChange}    UserID=${UserID}    SecurityID=${SecurityID}    IPAddress=${IPAddress}    MacAddress=${MacAddress}    Operway=${Operway}
    [Return]    ${ret}

Base_Bind_ReqTransferFund
    [Arguments]    ${Amount}    ${TransferDirection}    ${ApplySerial}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_Bind_ReqTransferFund    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    5108
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_rtn    OnRtnTransferFund    ${ApiID}    AccountID=${AccountID}    TransferDirection=${TransferDirection}    Amount=${Amount}
    ...    TransferStatus=1    ApplySerial=${ApplySerial}
    [Return]    ${ret}

RF_Bind_ReqTransferFund
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqTransferFund    CTORATstpInputTransferFundField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}
    ...    Amount=${Amount}    DepartmentID=${DepartmentID}
    [Return]    ${ret}

Base_Bind_ReqDesignationRegistration
    [Arguments]    ${UserID}    ${ShareHolderID}    ${AccountID}    ${DesignationType}={    ${ApiID}=${ApiID}
    ${RequestID}    set variable    ${0}
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    #${OrderRef}    set variable
    RF_Bind_ReqDesignationRegistration    ${InvestorID}    ${OrderRef}    ${UserID}    ${DesignationType}    ${RequestID}    ${ShareHolderID}
    ...    ${BusinessUnitID}    ${AccountID}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspDesignationRegistration    ${ApiID}    InvestorID=${InvestorID}    UserID=${UserID}    ShareholderID=${ShareholderID}
    [Return]    ${ret}

RF_Bind_ReqDesignationRegistration
    [Arguments]    ${InvestorID}    ${OrderRef}    ${UserID}    ${DesignationType}    ${RequestID}    ${ShareholderID}
    ...    ${BusinessUnitID}    ${AccountID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqDesignationRegistration    CTORATstpInputDesignationRegistrationField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    OrderRef=${OrderRef}    UserID=${UserID}    DesignationType=${DesignationType}
    ...    RequestID=${RequestID}    ExchangeID=1    ShareholderID=${ShareholderID}    BusinessUnitID=${BusinessUnitID}    AccountID=${AccountID}    IPAddress=${IPAddress}
    ...    MacAddress=${MacAddress}
    [Return]    ${ret}

Base_Bind_ReqForceUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_Bind_ReqForceUserLogout    ${UserID}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspForceUserLogout    ${ApiID}    UserID=${UserID}

RF_Bind_ReqForceUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqForceUserLogout    CTORATstpForceUserLogoutField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}
    [Return]    ${ret}

Base_Bind_ReqForceUserExit
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_Bind_ReqForceUserExit    ${UserID}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspForceUserExit    ${ApiID}    UserID=${UserID}

RF_Bind_ReqForceUserExit
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqForceUserExit    CTORATstpForceUserLogoutField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}
    [Return]    ${ret}

Base_Bind_ReqUserPasswordUpdate
    [Arguments]    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}=${ApiID}
    RF_Bind_ReqUserPasswordUpdate    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspUserPasswordUpdate    ${ApiID}    UserID=${UserID}    OldPassword=******    NewPassword=******

RF_Bind_ReqUserPasswordUpdate
    [Arguments]    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqUserPasswordUpdate    CTORATstpUserPasswordUpdateField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}    OldPassword=${OldPassword}    NewPassword=${NewPassword}
    [Return]    ${ret}

Base_Bind_ReqActivateUser
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_Bind_ReqActivateUser    ${UserID}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspActivateUser    ${ApiID}    UserID=${UserID}

RF_Bind_ReqActivateUser
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqActivateUser    CTORATstpActivateUserField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}
    [Return]    ${ret}

Base_Bind_ReqVerifyUserPassword
    [Arguments]    ${UserID}    ${Password}    ${ApiID}=${ApiID}
    RF_Bind_ReqVerifyUserPassword    ${UserID}    ${Password}    ${ApiID}
    ${ret}    RF_Bind_template_check_rsp    OnRspVerifyUserPassword    ${ApiID}    UserID=${UserID}    Password=******

RF_Bind_ReqVerifyUserPassword
    [Arguments]    ${UserID}    ${Password}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqVerifyUserPassword    CTORATstpVerifyUserPasswordField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}    Password=${Password}
    [Return]    ${ret}

Base_Bind_ReqUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_Bind_ReqUserLogout    ${UserID}    ${ApiID}
    #RF_Bind_OnFrontDisconnected    ${ApiID}

RF_Bind_ReqUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqUserLogout    CTORATstpUserLogoutField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}
    [Return]    ${ret}

RF_Bind_OnFrontDisconnected
    [Arguments]    ${ApiID}=${ApiID}    ${nReason}=${-3}
    ${max_seq}=    get_max_seqno
    check call back    OnFrontDisconnected    ${ApiID}    ${max_seq}    nReason=${nReason}

Base_Bind_ReqInquiryJZFund
    [Arguments]    ${Amount}    ${TransferDirection}    ${ApplySerial}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_Bind_ReqInquiryJZFund    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    5108
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_rtn    OnRtnInquiryJZFund    ${ApiID}    AccountID=${AccountID}    TransferDirection=${TransferDirection}    Amount=${Amount}
    ...    TransferStatus=1
    [Return]    ${ret}

RF_Bind_ReqInquiryJZFund
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqInquiryJZFund    CTORATstpReqInquiryJZFundField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}
    ...    Amount=${Amount}    DepartmentID=${DepartmentID}
    [Return]    ${ret}

Base_Bind_ReqInquiryMaxOrderVolume
    [Arguments]    ${Amount}    ${TransferDirection}    ${ApplySerial}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_Bind_ReqInquiryMaxOrderVolume    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    5108
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_rtn    OnRtnInquiryMaxOrderVolume    ${ApiID}    AccountID=${AccountID}    TransferDirection=${TransferDirection}    Amount=${Amount}
    ...    TransferStatus=1
    [Return]    ${ret}

RF_Bind_ReqInquiryMaxOrderVolume
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqInquiryMaxOrderVolume    CTORATstpReqInquiryMaxOrderVolumeField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}
    ...    Amount=${Amount}    DepartmentID=${DepartmentID}
    [Return]    ${ret}

Base_Bind_ReqTransferCollateral
    [Arguments]    ${Amount}    ${TransferDirection}    ${ApplySerial}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_Bind_ReqTransferCollateral    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    5108
    ...    ${ApiID}    #${ret}    RF_Bind_template_check_rtn    OnRspQryFundTransferDetail    ${ApiID}    AccountID=${AccountID}
    ...    # TransferDirection=${TransferDirection}    Amount=${Amount}    # TransferStatus=1    ApplySerial=${ApplySerial}

RF_Bind_ReqTransferCollateral
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqTransferCollateral    CTORATstpInputTransferCollateralField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}
    ...    Amount=${Amount}    DepartmentID=${DepartmentID}
    [Return]    ${ret}
