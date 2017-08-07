*** Settings ***
Documentation     业务关键字
Resource          ../02resource/Base_ApiResource.robot
Library           BuiltIn
Resource          ../02resource/Qry_Resource.robot

*** Variables ***
${ApiID}          default
${Password}       123456
${AccountType}    1    # 普通账户
${CurrencyID}     CNY
${OrderRef}       ${0}
${RequestID}      ${0}
${IPAddress}      192.168.56.1
${MacAddress}     ${EMPTY}
${SystemFlag}     1
${ProductID}      0
${SecurityType}    0
${HedgeFlag}      1
${Port}           9500    # tserver:6500; front:9500
${Operway}        +
${TerminalInfo}    VipTest
${Adjust_Frozen}    ${0.1}    # 仅在买入委托时多冻结的资金

*** Keywords ***
Base_ReqUserLogin
    [Arguments]    ${UserID}    ${AccountType}=0    ${ApiID}=${ApiID}    ${Password}=${Password}
    RF_ReqUserLogin    ${UserID}    ${AccountType}    ${Password}    ${ApiID}
    RF_OnRspUserLogin    ${UserID}    ${AccountType}    ${ApiID}

Base_ReqUserLogout
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqUserLogout    ${UserID}    ${ApiID}
    RF_OnFrontDisconnected    ${ApiID}

Base_ReqOrderInsert
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
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    #${OrderRef}    set variable
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    InvestorID=${InvestorID}    SecurityID=${SecurityID}    UserID=${UserID}
    ...    ShareholderID=${ShareholderID}    ExchangeID=${ExchangeID}    VolumeTotalOriginal=${VolumeTotalOriginal}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}    #LimitPrice=${LimitPrice}
    ...    # OrderRef=${OrderRef}
    [Return]    ${ret}

Base_ReqOrderAction
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
    RF_ReqOrderAction    ${InvestorID}    \    ${OrderRef}    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    \    \    ${ApiID}
    RF_template_check_rsp    OnRspOrderAction    ${ApiID}

Status_OnRtnOrder
    [Arguments]    ${OrderStatus}    ${OrderSubmitStatus}    ${Volume}    ${Price}    ${SecurityID}=${SecurityID}    ${ApiID}=${ApiID}
    ...    &{kwargs}
    ${OrderRef}    convert to string    ${OrderRef}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${Price}    VolumeTotalOriginal=${Volume}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}    &{kwargs}
    [Return]    ${ret}

Base_OnRtnTrade
    [Arguments]    ${Price}    ${Volume}    ${Direction}    ${SecurityID}=${SecurityID}    ${ApiID}=${ApiID}    &{kwargs}
    ${ret}    RF_template_check_rtn    OnRtnTrade    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    Price=${Price}    Volume=${Volume}    AccountID=${AccountID}    Direction=${Direction}
    ...    &{kwargs}
    [Return]    ${ret}

Qry_AccountPosition
    [Arguments]    ${AccountID}    ${SecurityID}    ${ApiID}=${ApiID}
    #查询当前资金
    ${account}    Base_ReqQryTradingAccount    ${AccountID}    ${ApiID}
    #查询当前仓位
    ${pos}    Base_ReqQryPosition    ${SecurityID}    ${ApiID}
    &{dict}    create dictionary    TradingAccount=${account}    Position=${pos}
    [Return]    &{dict}

Check_TradingAccount
    [Arguments]    ${AccountID}    ${ApiID}=${ApiID}    &{kwargs}
    Base_ReqQryTradingAccount    ${AccountID}
    ${ret}    RF_template_check_qry    OnRspQryTradingAccount    ${ApiID}    &{kwargs}

Check_Position
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}    &{kwargs}
    Base_ReqQryPosition    ${SecurityID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryPosition    ${ApiID}    &{kwargs}

Check_PledgePosition
    [Arguments]    ${SecurityID}    ${ApiID}=${ApiID}    &{kwargs}
    Base_ReqQryPledgePosition    ${SecurityID}    ${ApiID}
    ${ret}    RF_template_check_qry    OnRspQryPledgePosition    ${ApiID}    &{kwargs}

Error_OrderInsert
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${VolumeTotalOriginal}    ${Direction}    ${ErrorID}    ${ApiID}=${ApiID}
    ${OrderPriceType}    set variable    2    #TORA_TSTP_OPT_LimitPrice
    ${CombOffsetFlag}    set variable    0
    ${CombHedgeFlag}    set variable    1
    ${TimeCondition}    set variable    3    #TORA_TSTP_TC_GFD
    ${GTDDate}    set variable
    ${VolumeCondition}    set variable    1    #TORA_TSTP_VC_AV
    ${MinVolume}    set variable    ${0}
    ${ForceCloseReason}    set variable    6    #TORA_TSTP_FCC_Other
    ${RequestID}    set variable    ${0}
    ${UserForceClose}    set variable    ${0}
    ${IsSwapOrder}    set variable    ${0}
    ${CreditPositionType}    set variable
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_err    OnErrRtnOrderInsert    ${ErrorID}    ${ApiID}

Base_MarketOrder
    [Arguments]    ${SecurityID}    ${Direction}    ${Volume}    ${TimeCondition}=1    ${ApiID}=${ApiID}    #TORA_TSTP_TC_IOC 1,TORA_TSTP_TC_GFD 3
    ${OrderPriceType}    set variable    G    #TORA_TSTP_OPT_FiveLevelPrice
    ${Direction}    set variable    ${Direction}
    ${CombOffsetFlag}    set variable    0
    ${CombHedgeFlag}    set variable    1
    ${GTDDate}    set variable
    ${VolumeCondition}    set variable    1    #TORA_TSTP_VC_AV
    ${MinVolume}    set variable    ${0}
    ${ForceCloseReason}    set variable    6    #TORA_TSTP_FCC_Other
    ${IsAutoSuspend}    set variable    ${0}
    ${RequestID}    set variable    ${0}
    ${UserForceClose}    set variable    ${0}
    ${IsSwapOrder}    set variable    ${0}
    ${CreditPositionType}    set variable
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    ${LimitPrice}    set variable    ${0}    #不校验此字段
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${Volume}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${Volume}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}

Base_ReqIPO
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${VolumeTotalOriginal}    ${ApiID}=${ApiID}
    ${OrderPriceType}    set variable    2    #TORA_TSTP_OPT_LimitPrice
    ${Direction}    set variable    4    #TORA_TSTP_D_IPO
    ${CombOffsetFlag}    set variable    0
    ${CombHedgeFlag}    set variable    1
    ${TimeCondition}    set variable    3    #TORA_TSTP_TC_GFD
    ${VolumeCondition}    set variable    1    #TORA_TSTP_VC_AV
    ${MinVolume}    set variable    ${0}
    ${ForceCloseReason}    set variable    6    #TORA_TSTP_FCC_Other
    ${IsAutoSuspend}    set variable    ${0}
    ${RequestID}    set variable    ${0}
    ${UserForceClose}    set variable    ${0}
    ${CreditPositionType}    set variable    0
    ${IsSwapOrder}    set variable    ${0}
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${VolumeTotalOriginal}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}

Base_ReqRationed
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${VolumeTotalOriginal}    ${ApiID}=${ApiID}
    ${OrderPriceType}    set variable    2    #TORA_TSTP_OPT_LimitPrice
    ${Direction}    set variable    f    #TORA_TSTP_D_Rationed
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
    ${CreditPositionType}    set variable
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${VolumeTotalOriginal}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}

Failed_OrderAction
    [Arguments]    ${ErrorID}    ${SessionID}=${sid}    ${OrderRef}=${OrderRef}    ${OrderSysID}=\    ${ApiID}=${ApiID}
    ${RequestID}    set variable    ${0}
    ${FrontID}    set variable    ${1}
    #${SessionID}    set variable    ${0}
    #${OrderSysID}    set variable
    ${ActionFlag}    set variable    0
    ${LimitPrice}    set variable    ${0}
    ${VolumeChange}    set variable    ${0}
    ${OrderRef}    convert to string    ${OrderRef}
    RF_ReqOrderAction    ${InvestorID}    ${0}    ${OrderRef}    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    \    \    ${ApiID}
    RF_template_check_rsp    OnRspOrderAction    ${ApiID}    ${ErrorID}
    RF_template_check_err    OnErrRtnOrderAction    ${ErrorID}    ${ApiID}

Base_Connect
    [Arguments]    ${ApiID}=${ApiID}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    create_session    ${ApiID}
    register_front    tcp://${server_ip}:${Front1_Port}    ${ApiID}
    register_front    tcp://${server_ip}:${Front2_Port}    ${ApiID}
    connect    ${ApiID}
    check call back    OnFrontConnected    ${ApiID}    ${max_seq}

Base_Connect_nameserver
    [Arguments]    ${ApiID}=${ApiID}
    ${seq}=    get_max_seqno
    set suite variable    ${max_seq}    ${seq}
    create_session    ${ApiID}
    register_nameserver    tcp://${server_ip}:${Fens1_Port}    ${ApiID}
    register_nameserver    tcp://${server_ip}:${Fens2_Port}    ${ApiID}
    connect    ${ApiID}
    check call back    OnFrontConnected    ${ApiID}    ${max_seq}    time_out=${30}

Base_ReqOrderAction_OrderSysID
    [Arguments]    ${SecurityID}    ${OrderSysID}    ${ApiID}=${ApiID}
    ${RequestID}    set variable    ${0}
    #${FrontID}    set variable    ${1}
    ${SessionID}    set variable    ${sid}    #全局变量
    ${ActionFlag}    set variable    0
    ${LimitPrice}    set variable    ${0}
    ${VolumeChange}    set variable    ${0}
    ${OrderSubmitStatus1}    set variable    1
    ${OrderStatus1}    set variable    3
    ${OrderSubmitStatus2}    set variable    3
    ${OrderStatus2}    set variable    5
    RF_ReqOrderAction    ${InvestorID}    \    \    ${RequestID}    ${FrontID}    ${SessionID}
    ...    ${ExchangeID}    ${OrderSysID}    ${ActionFlag}    ${LimitPrice}    ${VolumeChange}    ${UserID}
    ...    ${SecurityID}    \    \    ${ApiID}    #RF_template_check_rtn    OnRtnOrder
    ...    # ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}    ShareholderID=${ShareholderID}    # InvestorID=${InvestorID}
    ...    # OrderStatus=${OrderStatus1}    OrderSubmitStatus=${OrderSubmitStatus1}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    #UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    # ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    OrderStatus=${OrderStatus2}    OrderSubmitStatus=${OrderSubmitStatus2}

Opposite_ReqUserLogin
    [Arguments]    ${UserID}    ${ApiID}=${ApiID}
    RF_ReqUserLogin    ${UserID}    0    ${Password}    ${ApiID}    \    ${EMPTY}
    ...    \    \    \    \    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspUserLogin    ${ApiID}    UserID=${UserID}    LogInAccountType=0
    Set Suite Variable    ${op_sid}    ${ret['SessionID']}
    [Return]    ${ret}

Business_OppositeOrder
    [Arguments]    ${no}    ${SecurityID}    ${LimitPrice}    ${TradedVolume}    ${Direction}
    [Documentation]    实际报单与Direction方向相反
    #${ApiID}    set variable    ${UserID${no}}
    ${InvestorID}    set variable    ${InvestorID${no}}
    ${ShareHolderID}    set variable    ${ShareHolderID${no}}
    ${AccountID}    set variable    ${AccountID${no}}
    #${UserID}    set variable    ${UserID${no}}
    ${BusinessUnitID}    set variable    ${InvestorID${no}}
    ${Direction}    set variable if    ${Direction}==1    0    ${Direction}==0    1    ${Direction}==5
    ...    6    ${Direction}==6    5
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
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${TradedVolume}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${TradedVolume}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}

Business_OtherOrder
    [Arguments]    ${no}    ${SecurityID}    ${LimitPrice}    ${TradedVolume}    ${Direction}
    [Documentation]    实际报单与Direction方向相反
    ${ApiID}    set variable    ${UserID${no}}
    ${InvestorID}    set variable    ${InvestorID${no}}
    ${ShareHolderID}    set variable    ${ShareHolderID${no}}
    ${AccountID}    set variable    ${AccountID${no}}
    ${UserID}    set variable    ${UserID${no}}
    ${BusinessUnitID}    set variable    ${InvestorID${no}}
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
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    \    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${TradedVolume}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID}    SecurityID=${SecurityID}    ExchangeID=${ExchangeID}
    ...    ShareholderID=${ShareholderID}    InvestorID=${InvestorID}    LimitPrice=${LimitPrice}    VolumeTotalOriginal=${TradedVolume}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}

Failed_OrderInsert
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${Volume}    ${Direction}    ${ErrorID}    ${ApiID}=${ApiID}
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
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID}    ${SecurityID}    ${OrderRef}    ${UserID}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${Volume}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID}    ${BusinessUnitID}    ${AccountID}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    RF_template_check_rsp    OnRspOrderInsert    ${ApiID}    ${ErrorID}
    RF_template_check_err    OnErrRtnOrderInsert    ${ErrorID}    ${ApiID}

switch_user
    [Arguments]    ${UserID}    ${InvestorID}    ${AccountID}    ${ShareHolderID}    ${ApiID}=${ApiID}
    set suite variable    ${UserID}    ${UserID}
    set suite variable    ${InvestorID}    ${InvestorID}
    set suite variable    ${AccountID}    ${AccountID}
    set suite variable    ${ShareHolderID}    ${ShareHolderID}
    set suite variable    ${BusinessUnitID}    ${InvestorID}
    #Base_connect    ${ApiID}
    Base_ReqUserLogin    ${UserID}    0    ${ApiID}

add_user
    [Arguments]    ${no}    ${UserID}    ${InvestorID}    ${AccountID}    ${ShareHolderID}    ${ApiID}
    set test variable    ${UserID${no}}    ${UserID}
    set test variable    ${InvestorID${no}}    ${InvestorID}
    set test variable    ${AccountID${no}}    ${AccountID}
    set test variable    ${ShareHolderID${no}}    ${ShareHolderID}
    set test variable    ${BusinessUnitID${no}}    ${InvestorID}
    set test variable    ${ApiID${no}}    ${ApiID}
    #Base_connect    ${ApiID${no}}
    #Base_ReqUserLogin    ${UserID${no}}    0    ${ApiID${no}}

switch_product
    [Arguments]    ${SecurityID}    ${Price}    ${Volume}
    set test variable    ${SecurityID}    ${SecurityID}
    set test variable    ${Price}    ${Price}
    set test variable    ${Volume}    ${Volume}

Switch_ReqOrderInsert
    [Arguments]    ${SecurityID}    ${LimitPrice}    ${VolumeTotalOriginal}    ${Direction}    ${ApiID}    ${no}
    ${OrderPriceType}    set variable    2    #TORA_TSTP_OPT_LimitPrice
    ${CombOffsetFlag}    set variable    0
    ${CombHedgeFlag}    set variable    1
    ${TimeCondition}    set variable    3    #TORA_TSTP_TC_GFD
    ${GTDDate}    set variable
    ${VolumeCondition}    set variable    1    #TORA_TSTP_VC_AV
    ${MinVolume}    set variable    ${0}
    ${ContingentCondition}    set variable    1    #TORA_TSTP_CC_Immediately
    ${StopPrice}    set variable    ${0}
    ${ForceCloseReason}    set variable    6    #TORA_TSTP_FCC_Other
    ${IsAutoSuspend}    set variable    ${0}
    ${RequestID}    set variable    ${0}
    ${UserForceClose}    set variable    ${0}
    ${IsSwapOrder}    set variable    ${0}
    ${BusinessUnit}    set variable
    ${CreditPositionType}    set variable    0
    ${OrderStatus}    set variable    a    #TORA_TSTP_OST_Unknown
    ${OrderSubmitStatus}    set variable    0    #TORA_TSTP_OSS_InsertSubmitted
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    RF_ReqOrderInsert    ${InvestorID${no}}    ${SecurityID}    ${OrderRef}    ${UserID${no}}    ${OrderPriceType}    ${Direction}
    ...    ${CombOffsetFlag}    ${CombHedgeFlag}    ${LimitPrice}    ${VolumeTotalOriginal}    ${TimeCondition}    ${VolumeCondition}
    ...    ${MinVolume}    ${ForceCloseReason}    ${RequestID}    ${UserForceClose}    ${IsSwapOrder}    ${ExchangeID}
    ...    ${ShareHolderID${no}}    ${BusinessUnitID${no}}    ${AccountID${no}}    ${IPAddress}    ${MacAddress}    ${CreditPositionType}
    ...    ${ApiID}
    ${ret}    RF_template_check_rtn    OnRtnOrder    ${ApiID}    UserID=${UserID${no}}    SecurityID=${SecurityID}    BusinessUnitID=${BusinessUnitID${no}}
    ...    ExchangeID=${ExchangeID}    ShareholderID=${ShareholderID${no}}    InvestorID=${InvestorID${no}}    VolumeTotalOriginal=${VolumeTotalOriginal}    OrderStatus=${OrderStatus}    OrderSubmitStatus=${OrderSubmitStatus}
    ...    OrderRef=${OrderRef}    #LimitPrice=${LimitPrice}
    [Return]    ${ret}

Business_Order_NoTrade
    [Arguments]    ${SecurityID}    ${Price}    ${Volume}    ${Commission}    ${Direction}=0
    ${AccountPositionDict}    Qry_AccountPosition    ${AccountID}    ${SecurityID}
    #报单
    Base_ReqOrderInsert    SecurityID=${SecurityID}    LimitPrice=${Price}    VolumeTotalOriginal=${Volume}    Direction=${Direction}
    ${OrderStatus2}    set variable    3    #TORA_TSTP_OST_NoTradeQueueing
    ${OrderSubmitStatus2}    set variable    3    #TORA_TSTP_OSS_Accepted
    Status_OnRtnOrder    ${OrderStatus2}    ${OrderSubmitStatus2}    ${Volume}    ${Price}
    #验证资金
    run keyword if    ${Direction}==0    Check_TradingAccount    ${AccountID}    ${AccountPositionDict['TradingAccount']['Available']-(${Price}*${Volume})-${Commission}}    ${AccountPositionDict['TradingAccount']['FrozenCommission']+${Commission}}    ${AccountPositionDict['TradingAccount']['FrozenCash']+${Price}*${Volume}}
    run keyword if    ${Direction}==1    Check_TradingAccount    ${AccountID}    ${AccountPositionDict['TradingAccount']['Available']-${Commission}}    ${AccountPositionDict['TradingAccount']['FrozenCommission']+${Commission}}    ${AccountPositionDict['TradingAccount']['FrozenCash']}
    #验证仓位
    run keyword if    ${Direction}==0    Check_Position    ${SecurityID}    ${AccountPositionDict['Position']['TodayBSPos']}    ${AccountPositionDict['Position']['HistoryPos']}    ${AccountPositionDict['Position']['HistoryPosFrozen']}
    ...    ${AccountPositionDict['Position']['TodayBSFrozen']}    ${AccountPositionDict['Position']['TodaySMPos']}    ${AccountPositionDict['Position']['TodaySMPosFrozen']}    ${AccountPositionDict['Position']['TodayPRPos']}    ${AccountPositionDict['Position']['TodayPRFrozen']}
    run keyword if    ${Direction}==1    Check_Position    ${SecurityID}    ${AccountPositionDict['Position']['TodayBSPos']}    ${AccountPositionDict['Position']['HistoryPos']}    ${AccountPositionDict['Position']['HistoryPosFrozen']+${Volume}}
    ...    ${AccountPositionDict['Position']['TodayBSFrozen']}    ${AccountPositionDict['Position']['TodaySMPos']}    ${AccountPositionDict['Position']['TodaySMPosFrozen']}    ${AccountPositionDict['Position']['TodayPRPos']}    ${AccountPositionDict['Position']['TodayPRFrozen']}
    [Teardown]    Base_ReqOrderAction    ${SecurityID}    # 撤单

Business_Order_Traded
    [Arguments]    ${SecurityID}    ${Price}    ${Volume}    ${TradedVolume}    ${Commission}    ${Direction}=0
    [Documentation]    600股部分成交（测试桩）
    #对手方报单
    Business_OppositeOrder    TradedVolume=${TradedVolume}    Direction=${Direction}    LimitPrice=${Price}    InvestorID=100009    AccountID=110100000009    ShareHolderID=A216053495
    #查询初始持仓
    ${AccountPositionDict}    Qry_AccountPosition    ${AccountID}    ${SecurityID}
    #报单
    Base_ReqOrderInsert    SecurityID=${SecurityID}    LimitPrice=${Price}    VolumeTotalOriginal=${Volume}    Direction=${Direction}
    run keyword if    ${Volume}==${500}    Status_OnRtnOrder    0    3    ${Volume}    ${Price}
    run keyword if    ${Volume}==${600}    Status_OnRtnOrder    1    3    ${Volume}    ${Price}
    Base_OnRtnTrade    ${Price}    ${TradedVolume}    ${Direction}
    #验证资金
    ${FrozenCommission}    set variable if    ${Volume-${TradedVolume}}!=${0}    ${AccountPositionDict['TradingAccount']['FrozenCommission']+${Commission}}    ${Volume-${TradedVolume}}==${0}    ${AccountPositionDict['TradingAccount']['FrozenCommission']}    #部份成交则冻结手续费
    ...    #全部成交则无需冻结手续费
    run keyword if    ${Direction}==0    Check_TradingAccount    ${AccountID}    ${AccountPositionDict['TradingAccount']['Available']-(${Price}*${Volume})-${Commission}}    ${FrozenCommission}    ${AccountPositionDict['TradingAccount']['FrozenCash']+${Price}*(${Volume-${TradedVolume}})}
    ...    #手续费
    run keyword if    ${Direction}==1    Check_TradingAccount    ${AccountID}    ${AccountPositionDict['TradingAccount']['Available']+${Price}*${TradedVolume}-${Commission}}    ${FrozenCommission}    ${AccountPositionDict['TradingAccount']['FrozenCash']}
    #验证仓位
    run keyword if    ${Direction}==0    Check_Position    ${SecurityID}    ${AccountPositionDict['Position']['TodayBSPos']+${TradedVolume}}    ${AccountPositionDict['Position']['HistoryPos']}    ${AccountPositionDict['Position']['HistoryPosFrozen']}
    ...    ${AccountPositionDict['Position']['TodayBSFrozen']}    ${AccountPositionDict['Position']['TodaySMPos']}    ${AccountPositionDict['Position']['TodaySMPosFrozen']}    ${AccountPositionDict['Position']['TodayPRPos']}    ${AccountPositionDict['Position']['TodayPRFrozen']}
    run keyword if    ${Direction}==1    Check_Position    ${SecurityID}    ${AccountPositionDict['Position']['TodayBSPos']}    ${AccountPositionDict['Position']['HistoryPos']-${TradedVolume}}    ${AccountPositionDict['Position']['HistoryPosFrozen']+${Volume-${TradedVolume}}}
    ...    ${AccountPositionDict['Position']['TodayBSFrozen']}    ${AccountPositionDict['Position']['TodaySMPos']}    ${AccountPositionDict['Position']['TodaySMPosFrozen']}    ${AccountPositionDict['Position']['TodayPRPos']}    ${AccountPositionDict['Position']['TodayPRFrozen']}
    #撤单
    run keyword if    ${Volume-${TradedVolume}}!=${0}    Base_ReqOrderAction    SessionID=${sid}    OrderStatus1=1    #部分成交则撤单

Base_ReqAdjustShareholderTradingRight
    [Arguments]    ${ShareholderID}    ${SecurityID}    ${Direction}    ${bForbidden}    ${ApiID}=${ApiID}
    RF_ReqAdjustShareholderTradingRight    ${MarketID}    ${ShareholderID}    ${SystemFlag}    ${ProductID}    ${SecurityType}    ${SecurityID}
    ...    ${Direction}    ${HedgeFlag}    ${bForbidden}    ${ExchangeID}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspAdjustShareholderTradingRight    ${ApiID}    ShareholderID=${ShareholderID}    Direction=${Direction}

Base_ReqDesignationRegistration
    [Arguments]    ${UserID}    ${ShareHolderID}    ${AccountID}    ${DesignationType}={    ${ApiID}=${ApiID}
    ${RequestID}    set variable    ${0}
    set suite variable    ${OrderRef}    ${OrderRef+1}
    ${OrderRef}    Convert To String    ${OrderRef}
    #${OrderRef}    set variable
    RF_ReqDesignationRegistration    ${InvestorID}    ${OrderRef}    ${UserID}    ${DesignationType}    ${RequestID}    ${ShareHolderID}
    ...    ${BusinessUnitID}    ${AccountID}    ${ApiID}
    ${ret}    RF_template_check_rsp    OnRspDesignationRegistration    ${ApiID}    InvestorID=${InvestorID}    UserID=${UserID}    ShareholderID=${ShareholderID}
    [Return]    ${ret}

base_bindapiLogin
    \    ${UserID}    ${AccountType}    ${Password}    ${ApiID}
    RF_OnRspUserLogin    ${UserID}    ${AccountType}    ${ApiID}
