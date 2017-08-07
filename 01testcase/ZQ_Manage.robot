*** Settings ***
Documentation     a股限价单：
...               ·报单，撤单
...               ·部分成交
...               ·全部成交
...               ·修改数量:未实现
...               ·修改价格：未实现
...               ·报单失败
...
...               500全部成交
...               600部分成交
...               其他不成交
...
...               持仓
...
...               资金
Suite Setup       switch user    ${UserID}    ${InvestorID}    ${AccountID}    ${ShareHolderID}
Suite Teardown
Test Setup
Library           ApiTesterLib.src.library.ApiTestLib    ZQ
Resource          ../02resource/Base_ApiResource.robot
Library           BuiltIn
Resource          ../02resource/Test_Resource.robot
Library           Collections
Resource          ../02resource/Qry_Resource.robot
Resource          ../02resource/SH_ENV_variable.robot
Resource          ../02resource/BASE_ENV.robot

*** Variables ***
${UserID}         admin
${InvestorID}     5641452    # 8778825
${AccountID}      10044527    # 8470933
${ShareHolderID}    A509537465    # A623385117
${Volume}         ${100}
${BusinessUnitID}    ${InvestorID}
${Password}       123456
@{Opp_Info}       5521180    10028790    B880304814    # 8743015|8431687|A257107897
@{Investor_Info}    ${InvestorID}    ${AccountID}    ${ShareHolderID}
${InvestorFeeRate}    ${0.003}
${DepartmentID}    5108

*** Test Cases ***
DesignationRegistration
    #Base_ReqDesignationRegistration    600000    ${100}
    Base_ReqDesignationRegistration    600000    ${100}    q
