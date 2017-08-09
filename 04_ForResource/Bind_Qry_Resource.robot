*** Settings ***
Library           ApiTesterLib.src.library.ApiTestLib    ZQBIND
Library           BuiltIn
Resource          Base_Bind_ApiResource.robot

*** Keywords ***
Base_Bind_ReqQryTradingAccount
    [Arguments]    ${AccountID}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryTradingAccount    ${InvestorID}    ${CurrencyID}    ${AccountID}    ${AccountType}    ${DepartmentID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryTradingAccount    ${ApiID}
    [Return]    ${ret}

RF_Bind_ReqQryTradingAccount
    [Arguments]    ${InvestorID}    ${CurrencyID}    ${AccountID}    ${AccountType}    ${DepartmentID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryTradingAccount    CTORATstpQryTradingAccountField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

Base_Bind_ReqQryOrder
    [Arguments]    ${SecurityID}    ${OrderSysID}=\    ${ApiID}=${ApiID}
    RF_Bind_ReqQryOrder    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${OrderSysID}
    ...    \    \    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryOrder    ${ApiID}

RF_Bind_ReqQryOrder
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${OrderSysID}
    ...    ${InsertTimeStart}    ${InsertTimeEnd}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryOrder    CTORATstpQryOrderField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}
    ...    ShareholderID=${ShareholderID}    OrderSysID=${OrderSysID}    InsertTimeStart=${InsertTimeStart}

Base_Bind_ReqQryPosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryPosition    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${BusinessUnitID}
    ...    ${ApiID}
    ${dict}    RF_Bind_template_check_qry    OnRspQryPosition    ${ApiID}
    ${default}    create dictionary    HistoryPos=${0}    HistoryPosFrozen=${0}    TodayBSPos=${0}    TodayBSFrozen=${0}    TodayPRPos=${0}
    ...    TodayPRFrozen=${0}
    ${ret}    set variable if    ${dict}    ${dict}    ${default}
    [Return]    ${ret}

RF_Bind_ReqQryPosition
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryPosition    CTORATstpQryPositionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}
    [Return]    ${ret}

Base_Bind_ReqQryTrade
    [Arguments]    ${SecurityID}    ${TradeID}=\    ${ApiID}=${ApiID}
    RF_Bind_ReqQryTrade    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${TradeID}
    ...    \    \    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_Bind_template_check_Qry    OnRspQryTrade    ${ApiID}
    [Return]    ${ret}

RF_Bind_ReqQryTrade
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${TradeID}
    ...    ${TradeTimeStart}    ${TradeTimeEnd}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryTrade    CTORATstpQryTradeField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}
    [Return]    ${ret}

Base_Bind_ReqQryIPOInfo
    [Arguments]    ${SecurityID}=${EMPTY}
    RF_Bind_ReqQryIPOInfo    ${ExchangeID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_Bind_template_check_Qry    OnRspQryIPOInfo    ${ApiID}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

RF_Bind_ReqQryIPOInfo
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    #call api    CreateApiSession    ${ApiID}    ${UserID}    0
    #call api    SubscribePrivateTopic    ${ApiID}    ${2}    ${UserID}    0
    ${ret}    RF_Bind_template_req    ReqQryIPOInfo    CTORATstpQryIPOInfoField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${UserID}    0
    [Return]    ${ret}

Base_Bind_ReqQryETFFile
    [Arguments]    ${EtfSecurityID}    ${EtfCreRedSecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryEtfFile    ${ExchangeID}    ${EtfSecurityID}    ${EtfCreRedSecurityID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryETFFile    ${ApiID}

RF_Bind_ReqQryEtfFile
    [Arguments]    ${ExchangeID}    ${ETFSecurityID}    ${ETFCreRedSecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryETFFile    CTORATstpQryETFFileField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    ExchangeID=${ExchangeID}    ETFSecurityID=${ETFSecurityID}
    [Return]    ${ret}

Base_Bind_ReqQryBUProxy
    [Arguments]    ${ApiID}=${ApiID}
    RF_Bind_ReqQryBUProxy    ${InvestorID}    ${UserID}    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryBUProxy    ${ApiID}

RF_Bind_ReqQryBUProxy
    [Arguments]    ${InvestorID}    ${UserID}    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryBUProxy    CTORATstpQryBUProxyField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}
    [Return]    ${ret}

Base_Bind_ReqQryBusinessUnitAndTradingAcct
    [Arguments]    ${ProductID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryBusinessUnitAndTradingAcct    ${InvestorID}    ${BusinessUnitID}    ${ProductID}    ${AccountID}    ${CurrencyID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryBusinessUnitAndTradingAcct    ${ApiID}

RF_Bind_ReqQryBusinessUnitAndTradingAcct
    [Arguments]    ${InvestorID}    ${BusinessUnitID}    ${ProductID}    ${AccountID}    ${CurrencyID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryBusinessUnitAndTradingAcct    CTORATstpQryBusinessUnitAndTradingAcctField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    BusinessUnitID=${BusinessUnitID}    ProductID=${ProductID}    AccountID=${AccountID}
    [Return]    ${ret}

Base_Bind_ReqQryExchange
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryExchange    ${ExchangeID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryExchange    ${ApiID}

RF_Bind_ReqQryExchange
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryExchange    CTORATstpQryExchangeField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

Base_Bind_ReqQryInvestorTradingFee
    [Arguments]    ${ApiID}=${ApiID}
    RF_Bind_ReqQryInvestorTradingFee    ${InvestorID}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_bind_template_check_qry    OnRspQryInvestorTradingFee    ${ApiID}

RF_Bind_ReqQryInvestorTradingFee
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryInvestorTradingFee    CTORATstpQryInvestorTradingFeeField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

Base_Bind_ReqQryOrderAction
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryOrderAction    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryOrderAction    ${ApiID}

RF_Bind_ReqQryOrderAction
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryOrderAction    CTORATstpQryOrderActionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}
    [Return]    ${ret}

Base_Bind_ReqQryTradingFee
    [Arguments]    ${ApiID}=${ApiID}
    RF_Bind_ReqQryTradingFee    ${ExchangeID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryTradingFee    ${ApiID}

RF_Bind_ReqQryTradingFee
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryTradingFee    CTORATstpQryTradingFeeField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}
    [Return]    ${ret}

Base_Bind_ReqQryShareholderAccount
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryShareholderAccount    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    a    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryShareholderAccount    ${ApiID}

RF_Bind_ReqQryShareholderAccount
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${TradingCodeClass}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryShareholderAccount    CTORATstpQryShareholderAccountField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}    ShareholderID=${ShareholderID}
    ...    TradingCodeClass=${TradingCodeClass}
    [Return]    ${ret}

Base_Bind_ReqQryIPOQuota
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryIPOQuota    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryIPOQuota    ${ApiID}

RF_Bind_ReqQryIPOQuota
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryIPOQuota    CTORATstpQryIPOQuotaField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}
    [Return]    ${ret}

Base_Bind_ReqQrySecurity
    [Arguments]    ${SecurityID}    ${ExchangeInstID}=\    ${ApiID}=${ApiID}
    RF_Bind_ReqQrySecurity    ${SecurityID}    ${ExchangeID}    ${ExchangeInstID}    \    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQrySecurity    ${ApiID}    SecurityID=${SecurityID}
    [Return]    ${ret}

RF_Bind_ReqQrySecurity
    [Arguments]    ${SecurityID}    ${ExchangeID}    ${ExchangeInstID}    ${ProductID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQrySecurity    CTORATstpQrySecurityField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    ExchangeInstID=${ExchangeInstID}    ProductID=${ProductID}
    [Return]    ${ret}

Base_Bind_ReqQryInvestor
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryInvestor    ${InvestorID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryInvestor    ${ApiID}

RF_Bind_ReqQryInvestor
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryInvestor    CTORATstpQryInvestorField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}
    [Return]    ${ret}

Base_Bind_ReqQryETFBasket
    [Arguments]    ${ETFSecurityID}    ${SecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryETFBasket    ${ExchangeID}    ${ETFSecurityID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryETFBasket    ${ApiID}

RF_Bind_ReqQryETFBasket
    [Arguments]    ${ExchangeID}    ${ETFSecurityID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryETFBasket    CTORATstpQryETFBasketField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    ExchangeID=${ExchangeID}    ETFSecurityID=${ETFSecurityID}    SecurityID=${SecurityID}
    [Return]    ${ret}

Base_Bind_ReqQryMarketData
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryMarketData    ${SecurityID}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryMarketData    ${ApiID}
    [Return]    ${ret}

RF_Bind_ReqQryMarketData
    [Arguments]    ${SecurityID}    ${ExchangeID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryMarketData    CTORATstpQryMarketDataField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

Base_Bind_ReqQryBusinessUnit
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryBusinessUnit    ${InvestorID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryBusinessUnit    ${ApiID}

RF_Bind_ReqQryBusinessUnit
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryBusinessUnit    CTORATstpQryBusinessUnitField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}
    [Return]    ${ret}

Base_Bind_ReqQryBrokerUserFunction
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryBrokerUserFunction    ${UserID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryBrokerUserFunction    ${ApiID}

RF_Bind_ReqQryBrokerUserFunction
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryBrokerUserFunction    CTORATstpQryBrokerUserFunctionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}
    [Return]    ${ret}

Base_Bind_ReqQryOrderFundDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderSysID}=    ${InsertTimeStart}=    ${InsertTimeEnd}=    ${ApiID}=${ApiID}
    RF_Bind_ReqQryOrderFundDetail    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryOrderFundDetail    ${ApiID}

RF_Bind_ReqQryOrderFundDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryOrderFundDetail    CTORATstpQryOrderFundDetailField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    OrderSysID=${OrderSysID}
    ...    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

Base_Bind_ReqQryMarket
    [Arguments]    ${ApiID}=${ApiID}
    RF_Bind_ReqQryMarket    ${ExchangeID}    ${MarketID}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryMarket    ${ApiID}

RF_Bind_ReqQryMarket
    [Arguments]    ${ExchangeID}    ${MarketID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryMarket    CTORATstpQryMarketField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}
    [Return]    ${ret}

Base_Bind_ReqQryFundTransferDetail
    [Arguments]    ${AccountID}    ${DepartmentID}    ${TransferDirection}=    ${ApiID}=${ApiID}
    RF_Bind_ReqQryFundTransferDetail    ${AccountID}    ${DepartmentID}    ${TransferDirection}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryFundTransferDetail    ${ApiID}

RF_Bind_ReqQryFundTransferDetail
    [Arguments]    ${AccountID}    ${DepartmentID}    ${TransferDirection}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryFundTransferDetail    CTORATstpQryFundTransferDetailField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    DepartmentID=${DepartmentID}    TransferDirection=${TransferDirection}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

Base_Bind_ReqTransferPostion
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}=${ApiID}
    RF_Bind_ReqTransferPosition    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}
    ${ret}    RF_Bind_template_check_rtn    OnRtnTransferPosition    ${ApiID}    ShareholderID=${ShareholderID}    SecurityID=${SecurityID}    TransferStatus=1

RF_Bind_ReqTransferPosition
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${SecurityID}    ${Volume}    ${TransferDirection}    ${TransferPositionType}
    ...    ${ApplySerial}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqTransferPosition    CTORATstpInputTransferPositionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    BusinessUnitID=${BusinessUnitID}    ExchangeID=${ExchangeID}    ShareholderID=${ShareholderID}
    ...    SecurityID=${SecurityID}    ApplySerial=${ApplySerial}    TransferDirection=${TransferDirection}    Volume=${Volume}    TransferPositionType=${TransferPositionType}    MarketID=${MarketID}
    [Return]    ${ret}

Base_Bind_ReqQryPositionTransferDetail
    [Arguments]    ${ShareholderID}    ${SecurityID}    ${TransferDirection}={EMPTY}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryPositionTransferDetail    ${ShareholderID}    ${SecurityID}    ${TransferDirection}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryPositionTransferDetail    ${ApiID}

RF_Bind_ReqQryPositionTransferDetail
    [Arguments]    ${FuncName}    ${ApiID}=${ApiID}    &{kwargs}
    ${ret}    RF_Bind_template_req    ReqQryFundTransferDetail    CTORATstpQryFundTransferDetailField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    AccountID=${AccountID}    DepartmentID=${DepartmentID}    TransferDirection=${TransferDirection}    CurrencyID=${CurrencyID}
    [Return]    ${ret}

Base_Bind_ReqQryDesignationRegistration
    [Arguments]    ${InvestorID}    ${ShareHolderID}    ${OrderSysID}=${EMPTY}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryDesignationRegistration    ${InvestorID}    ${ShareHolderID}    ${OrderSysID}    \    \    ${BusinessUnitID}
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryDesignationRegistration    ${ApiID}

RF_Bind_ReqQryDesignationRegistration
    [Arguments]    ${InvestorID}    ${ShareholderID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryDesignationRegistration    CTORATstpQryDesignationRegistrationField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    ExchangeID=1    MarketID=1    ShareholderID=${ShareholderID}
    ...    OrderSysID=${OrderSysID}    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

Base_Bind_ReqQryUser
    [Arguments]    ${UserID}    ${UserType}=2    ${ApiID}=${ApiID}
    RF_Bind_ReqQryUser    ${UserID}    ${UserType}    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryUser    ${ApiID}

RF_Bind_ReqQryUser
    [Arguments]    ${UserID}    ${UserType}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryUser    CTORATstpQryUserField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    UserID=${UserID}    UserType=${UserType}
    [Return]    ${ret}

Base_Bind_ReqQryPledgeInfo
    [Arguments]    ${EtfSecurityID}    ${EtfCreRedSecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryPledgeInfo    ${ExchangeID}    888880    888880    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryPledgeInfo    ${ApiID}

RF_Bind_ReqQryPledgeInfo
    [Arguments]    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryPledgeInfo    CTORATstpQryPledgeInfoField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    SecurityID=${SecurityID}
    [Return]    ${ret}

Base_Bind_QryPositionTransferDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderSysID}=    ${InsertTimeStart}=    ${InsertTimeEnd}=    ${ApiID}=${ApiID}
    RF_Bind_QryPositionTransferDetail    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryPositionTransferDetail    ${ApiID}

RF_Bind_QryPositionTransferDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryPositionTransferDetail    CTORATstpQryPositionTransferDetailField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    OrderSysID=${OrderSysID}
    ...    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

Base_Bind_QryFundTransferDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderSysID}=    ${InsertTimeStart}=    ${InsertTimeEnd}=    ${ApiID}=${ApiID}
    RF_Bind_QryFundTransferDetail    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${ApiID}
    ${ret}    RF_Bind_template_check_qry    OnRspQryFundTransferDetail    ${ApiID}

RF_Bind_QryFundTransferDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${BusinessUnitID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryFundTransferDetail    CTORATstpQryFundTransferDetailField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    OrderSysID=${OrderSysID}
    ...    InsertTimeStart=${InsertTimeStart}    InsertTimeEnd=${InsertTimeEnd}    BusinessUnitID=${BusinessUnitID}
    [Return]    ${ret}

Base_Bind_QryConversionBondInfo
    [Arguments]    ${SecurityID}=${EMPTY}
    RF_Bind_ReqQryConversionBondInfo    ${ExchangeID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_Bind_template_check_Qry    OnRspQryConversionBondInfo    ${ApiID}
    [Return]    ${ret}

RF_Bind_ReqQryConversionBondInfo
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryConversionBondInfo    CTORATstpQryConversionBondInfoField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${UserID}    0
    [Return]    ${ret}

Base_Bind_ReqQryBondPutbackInfo
    [Arguments]    ${SecurityID}=${EMPTY}
    RF_Bind_ReqQryBondPutbackInfo    ${ExchangeID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_Bind_template_check_Qry    OnRspQryBondPutbackInfo    ${ApiID}
    [Return]    ${ret}

RF_Bind_ReqQryBondPutbackInfo
    [Arguments]    ${ExchangeID}    ${SecurityID}    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryBondPutbackInfo    CTORATstpQryBondPutbackInfoField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${UserID}    0
    [Return]    ${ret}

Base_Bind_ReqQryPledgePosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryPledgePosition    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${BusinessUnitID}
    ...    ${ApiID}
    ${dict}    RF_Bind_template_check_qry    OnRspQryPledgePosition    ${ApiID}
    ${default}    create dictionary    HistoryPos=${0}    HistoryPosFrozen=${0}    TodayBSPos=${0}    TodayBSFrozen=${0}
    ${ret}    set variable if    ${dict}    ${dict}    ${default}
    [Return]    ${ret}

RF_Bind_ReqQryPledgePosition
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryPledgePosition    CTORATstpQryPledgePositionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}
    [Return]    ${ret}

Base_Bind_ReqQryStandardBondPosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_Bind_ReqQryStandardBondPosition    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${BusinessUnitID}
    ...    ${ApiID}
    ${dict}    RF_Bind_template_check_qry    OnRspQryStandardBondPosition    ${ApiID}
    ${default}    create dictionary    HistoryPos=${0}    HistoryPosFrozen=${0}    TodayBSPos=${0}    TodayBSFrozen=${0}
    ${ret}    set variable if    ${dict}    ${dict}    ${default}
    [Return]    ${ret}

RF_Bind_ReqQryStandardBondPosition
    [Arguments]    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareholderID}    ${BusinessUnitID}
    ...    ${ApiID}=${ApiID}
    ${ret}    RF_Bind_template_req    ReqQryStandardBondPosition    CTORATstpQryStandardBondPositionField    ${ApiID}    ${1}    ${DepartmentID}
    ...    ${LogInAccount}    ${LogInAccountType}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    MarketID=${MarketID}
    [Return]    ${ret}
