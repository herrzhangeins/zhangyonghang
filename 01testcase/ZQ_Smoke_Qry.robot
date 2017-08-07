*** Settings ***
Documentation     查询
...
...               持仓
...
...               资金
...
...               盘后可查
Suite Setup       Base_connect    Base_connect
...               AND    Base_ReqUserLogin    #Base_connect | Base_connect | # AND | Base_ReqUserLogin | ${UserID}
Suite Teardown    Base_ReqUserLogout    ${UserID}
Test Setup
Test Teardown
Library           ApiTesterLib.src.library.ApiTestLib    ZQ
Library           BuiltIn
Resource          ../02resource/Test_Resource.robot
Resource          ../02resource/Qry_Resource.robot
Resource          ../02resource/SZ_ENV_variable.robot
Resource          ../02resource/Manage_Resource.robot
Resource          ../02resource/BASE_ENV.robot

*** Variables ***
${ApiID}          default
${UserID}         admin
${Password}       123456
${InvestorID}     5500008
${AccountID}      9
${ShareHolderID}    0031336757
${BusinessUnitID}    ${InvestorID}
${AccountType}    1    # 普通账户
${CurrencyID}     CNY
${OrderRef}       ${0}
${Volume}         ${100}
${ProductID}      SHStock
${DepartmentID}    1103

*** Test Cases ***
QryTradingAccount
    Base_ReqQryTradingAccount    ${AccountID}    ${EMPTY}
    RF_template_check_qry    OnRspQryTradingAccount    ${ApiID}    AccountID=${AccountID}    AccountType=${AccountType}    DepartmentID=${DepartmentID}

QryOrder
    Base_ReqOrderInsert    ${SecurityID}    ${Price}    ${Volume}    0
    Base_ReqOrderAction    ${SecurityID}
    Base_ReqQryOrder    ${SecurityID}
    RF_template_check_qry    OnRspQryOrder    ${ApiID}    AccountID=${AccountID}

QryPosition
    Base_ReqQryPosition    ${SecurityID}
    RF_template_check_qry    OnRspQryPosition    SecurityID=${SecurityID}

QryTrade
    Base_ReqOrderInsert    ${SecurityID}    ${Price}    ${Volume}    0
    Base_ReqOrderInsert    ${SecurityID}    ${Price}    ${Volume}    1
    Base_ReqQryTrade    ${SecurityID}
    RF_template_check_qry    OnRspQryTrade    SecurityID=${SecurityID}

QryIPOInfo
    Base_ReqQryIPOInfo
    RF_template_check_qry    OnRspQryIPOInfo    SecurityID=002852

QryEtfFile
    [Tags]
    Base_ReqQryETFFile    159901    159901
    RF_template_check_qry    OnRspQryETFFile    ${ApiID}    ExchangeID=${ExchangeID}

QryBUProxy
    [Tags]
    Base_ReqQryBUProxy

QryBusinessUnitAndTradingAcct
    [Tags]
    Base_ReqQryBusinessUnitAndTradingAcct    ${EMPTY}

QryExchange
    Base_ReqQryExchange    ${ExchangeID}

QryInvestorTradingFee
    [Tags]
    Base_ReqQryInvestorTradingFee

QryUser
    [Documentation]    只有管理员可查询用户
    [Tags]
    Base_ReqQryUser    ${InvestorID}
    RF_template_check_qry    OnRspQryUser    ${ApiID}    UserID=${InvestorID}

QryOrderAction
    [Tags]
    Base_ReqOrderInsert    ${SecurityID}    ${Price}    ${Volume}    0
    Base_ReqOrderAction    ${SecurityID}
    Base_ReqQryOrderAction    ${InvestorID}

QryTradingFee
    Base_ReqQryTradingFee

QryShareholderAccount
    Base_ReqQryShareholderAccount    ${InvestorID}

QryIPOQuota
    Base_ReqQryIPOQuota    ${InvestorID}

QrySecurity
    Base_ReqQrySecurity    600000

QryInvestor
    Base_ReqQryInvestor    ${InvestorID}

QryETFBasket
    [Tags]
    Base_ReqQryETFBasket    511010    019315

QryMarketData
    Base_ReqQryMarketData    ${SecurityID}

QryBusinessUnit
    Base_ReqQryBusinessUnit    ${InvestorID}

QryBrokerUserFunction
    [Tags]
    Base_ReqQryBrokerUserFunction    ${UserID}

QryOrderFundDetail
    Base_ReqQryOrderFundDetail    ${InvestorID}    ${SecurityID}

QryMarket
    [Tags]    failed
    Base_ReqQryMarket

QryFundTransferDetail
    Base_ReqTransferFund    ${0.01}    1    00000001    ${DepartmentID}
    Base_ReqQryFundTransferDetail    ${AccountID}    ${DepartmentID}

QryPositionTransferDetail
    Base_ReqTransferPostion    ${InvestorID}    ${ShareHolderID}    ${SecurityID}    ${100}    0    1
    ...    ${EMPTY}
    Base_ReqQryPositionTransferDetail    ${ShareHolderID}    ${SecurityID}

QryDesignationRegistration
    Base_ReqQryDesignationRegistration    ${Empty}    ${EMPTY}
    RF_template_check_qry    OnRspQryDesignationRegistration    ${ApiID}

*** Keywords ***
