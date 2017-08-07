*** Settings ***
Library           BuiltIn
Library           ApiTesterLib.src.library.ApiTestLib    ZQ
Resource          Tpl_ApiResource.robot

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

*** Keywords ***
RF_ReqUserLogin
    [Arguments]    ${LogInAccount}    ${LogInAccountType}    ${Password}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqUserLogin    CTORATstpReqUserLoginField    ${ApiID}    ${1}    LogInAccount=${LogInAccount}
    ...    LogInAccountType=${LogInAccountType}    Password=${Password}    UserProductInfo=${UserProductInfo}    InterfaceProductInfo=${InterfaceProductInfo}    ProtocolInfo=${ProtocolInfo}    MacAddress=${MacAddress}
    ...    OneTimePassword=${OneTimePassword}    ClientIPAddress=${ClientIPAddress}    Lang=${Lang}    DepartmentID=${DepartmentID}    TerminalInfo=${TerminalInfo}
    [Return]    ${ret}

RF_ReqUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqUserLogout    CTORATstpUserLogoutField    ${ApiID}    ${1}    UserID=${UserID}
    [Return]    ${ret}

RF_ReqForceUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqForceUserLogout    CTORATstpForceUserLogoutField    ${ApiID}    ${1}    UserID=${UserID}
    [Return]    ${ret}

RF_ReqForceUserExit
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqForceUserExit    CTORATstpForceUserLogoutField    ${ApiID}    ${1}    UserID=${UserID}
    [Return]    ${ret}

RF_ReqUserPasswordUpdate
    [Arguments]    ${UserID}    ${OldPassword}    ${NewPassword}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqUserPasswordUpdate    CTORATstpUserPasswordUpdateField    ${ApiID}    ${1}    UserID=${UserID}
    ...    OldPassword=${OldPassword}    NewPassword=${NewPassword}
    [Return]    ${ret}

RF_ReqActivateUser
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqActivateUser    CTORATstpActivateUserField    ${ApiID}    ${1}    UserID=${UserID}
    [Return]    ${ret}

RF_ReqVerifyUserPassword
    [Arguments]    ${UserID}    ${Password}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqVerifyUserPassword    CTORATstpVerifyUserPasswordField    ${ApiID}    ${1}    UserID=${UserID}
    ...    Password=${Password}
    [Return]    ${ret}

RF_ReqOrderInsert
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareholderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqOrderInsert    CTORATstpInputOrderField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    OrderRef=${OrderRef}    UserID=${UserID}    OrderPriceType=${OrderPriceType}    Direction=${Direction}    CombOffsetFlag=${CombOffsetFlag}
    ...    CombHedgeFlag=${CombHedgeFlag}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${VolumeTotalOriginal}    TimeCondition=${TimeCondition}    VolumeCondition=${VolumeCondition}    MinVolume=${MinVolume}
    ...    ForceCloseReason=${ForceCloseReason}    RequestID=${RequestID}    TransfereePbuID=123    UserForceClose=${UserForceClose}    IsSwapOrder=${IsSwapOrder}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    BusinessUnitID=${BusinessUnitID}    AccountID=${AccountID}    IPAddress=${IPAddress}    MacAddress=${MacAddress}    CreditPositionType=${CreditPositionType}
    ...    Operway=${Operway}
    [Return]    ${ret}

RF_ReqOrderAction
    [Arguments]    ${InvestorID}    ${OrderActionRef}    ${OrderRef}    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    ${IPAddress}    ${MacAddress}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqOrderAction    CTORATstpInputOrderActionField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    OrderActionRef=${OrderActionRef}    OrderRef=${OrderRef}    RequestID=${RequestID}    FrontID=${FrontID}    SessionID=${SessionID}    ExchangeID=${ExchangeID}
    ...    OrderSysID=${OrderSysID}    ActionFlag=${ActionFlag}    LimitPrice=${LimitPrice}    VolumeChange=${VolumeChange}    UserID=${UserID}    SecurityID=${SecurityID}
    ...    IPAddress=${IPAddress}    MacAddress=${MacAddress}    Operway=${Operway}
    [Return]    ${ret}

RF_ReqTransferFund
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${DepartmentID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqTransferFund    CTORATstpInputTransferFundField    ${ApiID}    ${1}    AccountID=${AccountID}
    ...    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}    Amount=${Amount}    DepartmentID=${DepartmentID}
    [Return]    ${ret}

RF_ReqTransferPosition
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqTransferPosition    CTORATstpInputTransferPositionField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    BusinessUnitID=${BusinessUnitID}    ExchangeID=${ExchangeID}    ShareholderID=${ShareholderID}    SecurityID=${SecurityID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}
    ...    Volume=${Volume}    TransferPositionType=${TransferPositionType}    MarketID=${MarketID}
    [Return]    ${ret}

RF_ReqRepealFund
    [Arguments]    ${RepealFundSerial}    ${FrontID}    ${SessionID}    ${RepealApplySerial}    ${AccountID}    ${CurrencyID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqRepealFund    CTORATstpInputRepealFundField    ${ApiID}    ${1}    RepealFundSerial=${RepealFundSerial}
    ...    FrontID=${FrontID}    SessionID=${SessionID}    RepealApplySerial=${RepealApplySerial}    AccountID=${AccountID}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

RF_ReqSubMarketData
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqSubMarketData    CTORATstpSpecificInstrumentField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    SecurityID=${SecurityID}
    [Return]    ${ret}

RF_ReqUnSubMarketData
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqUnSubMarketData    CTORATstpSpecificInstrumentField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    SecurityID=${SecurityID}
    [Return]    ${ret}

RF_ReqQryETFFile
    [Arguments]    ${ExchangeID}    ${ETFSecurityID}    ${ETFCreRedSecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryETFFile    CTORATstpQryETFFileField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    ETFSecurityID=${ETFSecurityID}    ETFCreRedSecurityID=${ETFCreRedSecurityID}
    [Return]    ${ret}

RF_ReqQryBusinessUnitAndTradingAcct
    [Arguments]    ${InvestorID}    ${BusinessUnitID}    ${ProductID}    ${AccountID}    ${CurrencyID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryBusinessUnitAndTradingAcct    CTORATstpQryBusinessUnitAndTradingAcctField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    BusinessUnitID=${BusinessUnitID}    ProductID=${ProductID}    AccountID=${AccountID}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

RF_ReqQryBUProxy
    [Arguments]    ${InvestorID}    ${UserID}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryBUProxy    CTORATstpQryBUProxyField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    UserID=${UserID}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryTradingAccount
    [Arguments]    ${InvestorID}    ${CurrencyID}    ${AccountID}    ${AccountType}    ${DepartmentID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryTradingAccount    CTORATstpQryTradingAccountField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    CurrencyID=${CurrencyID}    AccountID=${AccountID}    AccountType=${AccountType}    DepartmentID=${DepartmentID}
    [Return]    ${ret}

RF_ReqQryExchange
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryExchange    CTORATstpQryExchangeField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqQryOrderAction
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryOrderAction    CTORATstpQryOrderActionField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}
    [Return]    ${ret}

RF_ReqQryUser
    [Arguments]    ${UserID}    ${UserType}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryUser    CTORATstpQryUserField    ${ApiID}    ${1}    UserID=${UserID}
    ...    UserType=${UserType}
    [Return]    ${ret}

RF_ReqQryInvestor
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryInvestor    CTORATstpQryInvestorField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    [Return]    ${ret}

RF_ReqQryShareholderAccount
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${TradingCodeClass}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryShareholderAccount    CTORATstpQryShareholderAccountField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}    TradingCodeClass=${TradingCodeClass}
    [Return]    ${ret}

RF_ReqQryTradingFee
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryTradingFee    CTORATstpQryTradingFeeField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqQryIPOInfo
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryIPOInfo    CTORATstpQryIPOInfoField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    SecurityID=${SecurityID}
    [Return]    ${ret}

RF_ReqQryPosition
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryPosition    CTORATstpQryPositionField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryPledgePosition
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryPledgePosition    CTORATstpQryPledgePositionField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryPledgeInfo
    [Arguments]    ${SecurityID}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryPledgeInfo    CTORATstpQryPledgeInfoField    ${ApiID}    ${1}    SecurityID=${SecurityID}
    ...    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqQrySecurity
    [Arguments]    ${SecurityID}    ${ExchangeID}    ${ExchangeInstID}    ${ProductID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQrySecurity    CTORATstpQrySecurityField    ${ApiID}    ${1}    SecurityID=${SecurityID}
    ...    ExchangeID=${ExchangeID}    ExchangeInstID=${ExchangeInstID}    ProductID=${ProductID}
    [Return]    ${ret}

RF_ReqQryOrder
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${OrderSysID}
    ...    ${InsertTimeStart}    ${InsertTimeEnd}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryOrder    CTORATstpQryOrderField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}    OrderSysID=${OrderSysID}    InsertTimeStart=${InsertTimeStart}
    ...    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryIPOQuota
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryIPOQuota    CTORATstpQryIPOQuotaField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}
    [Return]    ${ret}

RF_ReqQryBusinessUnit
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryBusinessUnit    CTORATstpQryBusinessUnitField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    [Return]    ${ret}

RF_ReqQryInvestorTradingFee
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryInvestorTradingFee    CTORATstpQryInvestorTradingFeeField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqQryTrade
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${TradeID}
    ...    ${TradeTimeStart}    ${TradeTimeEnd}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryTrade    CTORATstpQryTradeField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}    TradeID=${TradeID}    TradeTimeStart=${TradeTimeStart}
    ...    TradeTimeEnd=${TradeTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryETFBasket
    [Arguments]    ${ExchangeID}    ${ETFSecurityID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryETFBasket    CTORATstpQryETFBasketField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    ETFSecurityID=${ETFSecurityID}    SecurityID=${SecurityID}
    [Return]    ${ret}

RF_ReqQryMarketData
    [Arguments]    ${SecurityID}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryMarketData    CTORATstpQryMarketDataField    ${ApiID}    ${1}    SecurityID=${SecurityID}
    ...    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqQryOrderFundDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryOrderFundDetail    CTORATstpQryOrderFundDetailField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    OrderSysID=${OrderSysID}    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_ReqQryMarket
    [Arguments]    ${ExchangeID}    ${MarketID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryMarket    CTORATstpQryMarketField    ${ApiID}    ${1}    ExchangeID=${ExchangeID}
    ...    MarketID=${MarketID}
    [Return]    ${ret}

RF_ReqQryBrokerUserFunction
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryBrokerUserFunction    CTORATstpQryBrokerUserFunctionField    ${ApiID}    ${1}    UserID=${UserID}
    [Return]    ${ret}

RF_ReqQryFundTransferDetail
    [Arguments]    ${AccountID}    ${DepartmentID}    ${TransferDirection}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryFundTransferDetail    CTORATstpQryFundTransferDetailField    ${ApiID}    ${1}    AccountID=${AccountID}
    ...    DepartmentID=${DepartmentID}    TransferDirection=${TransferDirection}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

RF_ReqQryPositionTransferDetail
    [Arguments]    ${ShareholderID}    ${SecurityID}    ${TransferDirection}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryPositionTransferDetail    CTORATstpQryPositionTransferDetailField    ${ApiID}    ${1}    SecurityID=${SecurityID}
    ...    ShareholderID=${ShareholderID}    TransferDirection=${TransferDirection}
    [Return]    ${ret}

RF_OnRspUserLogin
    [Arguments]    ${LogInAccount}    ${AccountType}=0    ${ApiID}=${ApiID}
    ${ret}    RF_template_check_rsp    OnRspUserLogin    ${ApiID}    LogInAccount=${LogInAccount}    LogInAccountType=${AccountType}
    Set Suite Variable    ${sid}    ${ret['SessionID']}
    Set Suite Variable    ${FrontID}    ${ret['FrontID']}
    [Return]    ${ret}

RF_OnRtnOrder
    [Arguments]    ${UserID}    ${SecurityID}    ${ExchangeID}    ${ShareholderID}    ${InvestorID}    ${Price}
    ...    ${Volumn}    ${OrderStatus}    ${OrderSubmitStatus}    ${OrderRef}    ${ApiID}=${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${Price}    VolumeTotalOriginal=${Volumn}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}
    [Return]    ${ret}

RF_OnFrontDisconnected
    [Arguments]    ${ApiID}=${ApiID}    ${nReason}=${-3}
    ${max_seq}=    get_max_seqno
    check call back    OnFrontDisconnected    ${ApiID}    ${max_seq}    nReason=${nReason}

RF_OnRtnOrder_Action
    [Arguments]    ${UserID}    ${SecurityID}    ${ExchangeID}    ${ShareholderID}    ${InvestorID}    ${OrderStatus}
    ...    ${OrderSubmitStatus}    ${ApiID}=${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    #OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}

RF_ReqMoveFund
    [Arguments]    ${AccountID}    ${CurrencyID}    ${ApplySerial}    ${TransferDirection}    ${Amount}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqMoveFund    CTORATstpInputMoveFundField    ${ApiID}    ${1}    AccountID=${AccountID}
    ...    CurrencyID=${CurrencyID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}    Amount=${Amount}
    [Return]    ${ret}

ReqQrySyncDeposit
    [Arguments]    ${FundSerial}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQrySyncDeposit    CTORATstpQrySyncDepositField    ${ApiID}    ${1}    FundSerial=${FundSerial}
    [Return]    ${ret}

RF_ReqAdjustShareholderTradingRight
    [Arguments]    ${MarketID}    ${ShareholderID}    ${SystemFlag}    ${ProductID}    ${SecurityType}    ${SecurityID}
    ...    ${Direction}    ${HedgeFlag}    ${bForbidden}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqAdjustShareholderTradingRight    CTORATstpReqAdjustShareholderTradingRightField    ${ApiID}    ${1}    MarketID=${MarketID}
    ...    ShareholderID=${ShareholderID}    SystemFlag=${SystemFlag}    ProductID=${ProductID}    SecurityType=${SecurityType}    SecurityID=${SecurityID}    Direction=${Direction}
    ...    HedgeFlag=${HedgeFlag}    bForbidden=${bForbidden}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_ReqDesignationRegistration
    [Arguments]    ${InvestorID}    ${OrderRef}    ${UserID}    ${DesignationType}    ${RequestID}    ${ShareholderID}
    ...    ${BusinessUnitID}    ${AccountID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqDesignationRegistration    CTORATstpInputDesignationRegistrationField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    OrderRef=${OrderRef}    UserID=${UserID}    DesignationType=${DesignationType}    RequestID=${RequestID}    ExchangeID=1    ShareholderID=${ShareholderID}
    ...    BusinessUnitID=${BusinessUnitID}    AccountID=${AccountID}    IPAddress=${IPAddress}    MacAddress=${MacAddress}
    [Return]    ${ret}

RF_ReqQryDesignationRegistration
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_template_req    ReqQryDesignationRegistration    CTORATstpQryDesignationRegistrationField    ${ApiID}    ${1}    InvestorID=${InvestorID}
    ...    ExchangeID=1    MarketID=1    ShareholderID=${ShareholderID}    OrderSysID=${OrderSysID}    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}
    ...    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

RF_SubscribeMarketData
    [Arguments]    ${ApiID}=${ApiID}    @{Securities}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    ${arr}    get_char_arr    @{Securities}
    ${count}    Get Length    ${Securities}
    ${ret}    call api    SubscribeMarketData    ${ApiID}    ${arr}    ${count}    1
    RF_template_check_rsp    OnRspSubMarketData
    [Return]    ${ret}

RF_UnSubscribeMarketData
    [Arguments]    ${ApiID}=${ApiID}    @{Securities}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    ${arr}    get_char_arr    @{Securities}
    ${count}    Get Length    ${Securities}
    ${ret}    call api    UnSubscribeMarketData    ${ApiID}    ${arr}    ${count}    1
    RF_template_check_rsp    OnRspUnSubMarketData
    [Return]    ${ret}

RF_OnRtnDepthMarketData
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnDepthMarketData    ${ApiID}    SecurityID=${SecurityID}
    [Return]    ${ret}
