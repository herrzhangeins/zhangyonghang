*** Settings ***
Documentation     业务关键字
Resource          ../02resource/Base_ApiResource.robot
Library           BuiltIn

*** Variables ***
${ApiID}          default
${Password}       123456
${AccountType}    1    # 普通账户
${CurrencyID}     CNY
${OrderRef}       ${0}
${RequestID}      ${0}

*** Keywords ***
Base_ReqQryTradingAccount
    [Arguments]    ${AccountID}    ${DepartmentID}=${DepartmentID}    ${ApiID}=${ApiID}
    RF_ReqQryTradingAccount    ${InvestorID}    ${CurrencyID}    ${AccountID}    ${AccountType}    ${DepartmentID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryTradingAccount    ${ApiID}
    [Return]    ${ret}

Base_ReqQryPosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_ReqQryPosition    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${BusinessUnitID}
    ...    ${ApiID}
    ${dict}    RF_template_check_qry    OnRspQryPosition    ${ApiID}
    ${default}    create dictionary    HistoryPos=${0}    HistoryPosFrozen=${0}    TodayBSPos=${0}    TodayBSFrozen=${0}    TodayPRPos=${0}
    ...    TodayPRFrozen=${0}
    ${ret}    set variable if    ${dict}    ${dict}    ${default}
    [Return]    ${ret}

Base_ReqQryPledgePosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_ReqQryPledgePosition    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${BusinessUnitID}
    ...    ${ApiID}
    ${dict}    RF_template_check_qry    OnRspQryPledgePosition    ${ApiID}
    ${default}    create dictionary    HisPledgePos=${0}    HisPledgePosFrozen=${0}    TodayPledgePos=${0}    TodayPledgePosFrozen=${0}
    ${ret}    set variable if    ${dict}    ${dict}    ${default}
    [Return]    ${ret}

Base_ReqQryTrade
    [Arguments]    ${SecurityID}    ${TradeID}=\    ${ApiID}=${ApiID}
    RF_ReqQryTrade    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${TradeID}
    ...    \    \    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_template_check_Qry    OnRspQryTrade    ${ApiID}
    [Return]    ${ret}

Base_ReqQryIPOInfo
    [Arguments]    ${SecurityID}=${EMPTY}
    RF_ReqQryIPOInfo    ${ExchangeID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_template_check_Qry    OnRspQryIPOInfo    ${ApiID}    ExchangeID=${ExchangeID}
    [Return]    ${ret}

Base_ReqQryOrder
    [Arguments]    ${SecurityID}    ${OrderSysID}=\    ${ApiID}=${ApiID}
    RF_ReqQryOrder    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${OrderSysID}
    ...    \    \    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryOrder    ${ApiID}

Base_ReqQryEtfFile
    [Arguments]    ${EtfSecurityID}    ${EtfCreRedSecurityID}    ${ApiID}=${ApiID}
    RF_ReqQryEtfFile    ${ExchangeID}    ${EtfSecurityID}    ${EtfCreRedSecurityID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryETFFile    ${ApiID}

Base_ReqQryBUProxy
    [Arguments]    ${ApiID}=${ApiID}
    RF_ReqQryBUProxy    ${InvestorID}    ${UserID}    ${BusinessUnitID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryBUProxy    ${ApiID}

Base_ReqQryBusinessUnitAndTradingAcct
    [Arguments]    ${ProductID}    ${ApiID}=${ApiID}
    RF_ReqQryBusinessUnitAndTradingAcct    ${InvestorID}    ${BusinessUnitID}    ${ProductID}    ${AccountID}    ${CurrencyID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryBusinessUnitAndTradingAcct    ${ApiID}

Base_ReqQryExchange
    [Arguments]    ${ExchangeID}    ${ApiID}=${ApiID}
    RF_ReqQryExchange    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryExchange    ${ApiID}

Base_ReqQryInvestorTradingFee
    [Arguments]    ${ApiID}=${ApiID}
    RF_ReqQryInvestorTradingFee    ${InvestorID}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryInvestorTradingFee    ${ApiID}

Base_ReqQryUser
    [Arguments]    ${UserID}    ${UserType}=2    ${ApiID}=${ApiID}
    RF_ReqQryUser    ${UserID}    ${UserType}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryUser    ${ApiID}

Base_ReqQryOrderAction
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_ReqQryOrderAction    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryOrderAction    ${ApiID}

Base_ReqQryTradingFee
    [Arguments]    ${ApiID}=${ApiID}
    RF_ReqQryTradingFee    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryTradingFee    ${ApiID}

Base_ReqQryShareholderAccount
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_ReqQryShareholderAccount    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    a    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryShareholderAccount    ${ApiID}

Base_ReqQryIPOQuota
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_ReqQryIPOQuota    ${InvestorID}    ${ExchangeID}    ${MarketID}    ${ShareHolderID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryIPOQuota    ${ApiID}

Base_ReqQryPledgeInfo
    [Arguments]    ${SecurityID}    ${ExchangeInstID}=\    ${ApiID}=${ApiID}
    RF_ReqQryPledgeInfo    ${SecurityID}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryPledgeInfo    ${ApiID}
    [Return]    ${ret}

Base_ReqQrySecurity
    [Arguments]    ${SecurityID}    ${ExchangeInstID}=\    ${ApiID}=${ApiID}
    RF_ReqQrySecurity    ${SecurityID}    ${ExchangeID}    ${ExchangeInstID}    \    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQrySecurity    ${ApiID}
    [Return]    ${ret}

Base_ReqQryInvestor
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_ReqQryInvestor    ${InvestorID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryInvestor    ${ApiID}

Base_ReqQryETFBasket
    [Arguments]    ${ETFSecurityID}    ${SecurityID}    ${ApiID}=${ApiID}
    RF_ReqQryETFBasket    ${ExchangeID}    ${ETFSecurityID}    ${SecurityID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryETFBasket    ${ApiID}
    [Return]    ${ret}

Base_ReqQryMarketData
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}
    RF_ReqQryMarketData    ${SecurityID}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryMarketData    ${ApiID}
    [Return]    ${ret}

Base_ReqQryBusinessUnit
    [Arguments]    ${InvestorID}    ${ApiID}=${ApiID}
    RF_ReqQryBusinessUnit    ${InvestorID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryBusinessUnit    ${ApiID}

Base_ReqQryBrokerUserFunction
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqQryBrokerUserFunction    ${UserID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryBrokerUserFunction    ${ApiID}

Base_ReqQryOrderFundDetail
    [Arguments]    ${InvestorID}    ${SecurityID}    ${OrderSysID}=    ${InsertTimeStart}=    ${InsertTimeEnd}=    ${ApiID}=${ApiID}
    RF_ReqQryOrderFundDetail    ${InvestorID}    ${SecurityID}    ${ExchangeID}    ${OrderSysID}    ${InsertTimeStart}    ${InsertTimeEnd}
    ...    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryOrderFundDetail    ${ApiID}

Base_ReqQryMarket
    [Arguments]    ${ApiID}=${ApiID}
    RF_ReqQryMarket    ${ExchangeID}    ${MarketID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryMarket    ${ApiID}

Base_ReqQryFundTransferDetail
    [Arguments]    ${AccountID}    ${DepartmentID}    ${TransferDirection}=    ${ApiID}=${ApiID}
    RF_ReqQryFundTransferDetail    ${AccountID}    ${DepartmentID}    ${TransferDirection}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryFundTransferDetail    ${ApiID}

Base_ReqQryPositionTransferDetail
    [Arguments]    ${ShareholderID}    ${SecurityID}    ${TransferDirection}={EMPTY}    ${ApiID}=${ApiID}
    RF_ReqQryPositionTransferDetail    ${ShareholderID}    ${SecurityID}    ${TransferDirection}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryPositionTransferDetail    ${ApiID}

Empty_Qry
    [Arguments]    ${QryFunc}    ${Struct}    ${ApiID}=${ApiID}    &{kwargs}
    RF_template_req    ${QryFunc}    ${Struct}    ${ApiID}    ${1}    &{kwargs}
    &{rspinfo}    Create Dictionary    ErrorID=${0}
    ${list}    check call back    OnRsp${QryFunc[3:]}    ${ApiID}    ${max_seq}    pRspStruct=${None}    pRspInfo=&{rspinfo}
    ...    bIsLast=1
    ${ret}    set variable    ${list[0]['pRspStruct']}

Base_ReqQryDesignationRegistration
    [Arguments]    ${InvestorID}    ${ShareHolderID}    ${OrderSysID}=${EMPTY}    ${ApiID}=${ApiID}
    RF_ReqQryDesignationRegistration    ${InvestorID}    ${ShareHolderID}    ${OrderSysID}    \    \    ${BusinessUnitID}
    ...    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryDesignationRegistration    ${ApiID}
